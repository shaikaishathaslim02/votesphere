import express from 'express';
import pg from 'pg';
import crypto from 'node:crypto';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const { Pool } = pg;
const app = express();
const port = Number(process.env.PORT || 10000);
const pool = new Pool({ connectionString: process.env.DATABASE_URL, ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false });
const root = path.dirname(fileURLToPath(import.meta.url));

app.use(express.json());

async function schema() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS polls (
      id UUID PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL,
      room_code VARCHAR(12) UNIQUE NOT NULL, creator_id TEXT NOT NULL,
      deadline TIMESTAMPTZ NOT NULL, status TEXT NOT NULL DEFAULT 'open',
      created_at TIMESTAMPTZ NOT NULL DEFAULT now()
    );
    CREATE TABLE IF NOT EXISTS candidates (
      id UUID PRIMARY KEY, poll_id UUID NOT NULL REFERENCES polls(id) ON DELETE CASCADE,
      name TEXT NOT NULL, vote_count INTEGER NOT NULL DEFAULT 0
    );
    CREATE TABLE IF NOT EXISTS votes (
      id UUID PRIMARY KEY, poll_id UUID NOT NULL REFERENCES polls(id) ON DELETE CASCADE,
      candidate_id UUID NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
      voter_id TEXT NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
      UNIQUE (poll_id, voter_id)
    );
  `);
}

function publicPoll(row, candidates, revealVotes = false) {
  return { id: row.id, title: row.title, description: row.description, roomCode: row.room_code, deadline: row.deadline, status: row.status, candidates: candidates.map((candidate) => ({ ...candidate, votes: revealVotes ? Number(candidate.votes || 0) : 0 })) };
}

app.get('/api/health', async (_req, res) => {
  try { await pool.query('SELECT 1'); res.json({ ok: true }); }
  catch { res.status(503).json({ ok: false }); }
});

app.post('/api/polls', async (req, res) => {
  const { title, description, minutes, candidates, creatorId } = req.body ?? {};
  if (!title?.trim() || !description?.trim() || !Array.isArray(candidates) || candidates.length < 2 || candidates.some((n) => !String(n).trim())) return res.status(400).json({ error: 'Title, description, and at least two candidate names are required.' });
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const id = crypto.randomUUID(); const roomCode = String(Math.floor(100000 + Math.random() * 900000));
    const creator = creatorId || crypto.randomUUID(); const deadline = new Date(Date.now() + Math.max(1, Number(minutes) || 30) * 60000);
    const poll = await client.query('INSERT INTO polls(id,title,description,room_code,creator_id,deadline) VALUES($1,$2,$3,$4,$5,$6) RETURNING *', [id, title.trim(), description.trim(), roomCode, creator, deadline]);
    const result = [];
    for (const name of candidates) { const candidate = await client.query('INSERT INTO candidates(id,poll_id,name) VALUES($1,$2,$3) RETURNING *', [crypto.randomUUID(), id, String(name).trim()]); result.push(candidate.rows[0]); }
    await client.query('COMMIT');
    res.status(201).json({ poll: publicPoll(poll.rows[0], result.map((c) => ({ id: c.id, name: c.name, votes: 0 })), true), creatorId: creator });
  } catch (error) { await client.query('ROLLBACK'); res.status(500).json({ error: 'Could not create poll.' }); }
  finally { client.release(); }
});

app.get('/api/polls/:code', async (req, res) => {
  const poll = await pool.query('SELECT * FROM polls WHERE room_code=$1', [req.params.code]);
  if (!poll.rowCount) return res.status(404).json({ error: 'Poll not found.' });
  const candidates = await pool.query('SELECT id,name,vote_count AS votes FROM candidates WHERE poll_id=$1 ORDER BY name', [poll.rows[0].id]);
  res.json(publicPoll(poll.rows[0], candidates.rows, poll.rows[0].status === 'published'));
});

app.get('/api/polls/:code/dashboard', async (req, res) => {
  const poll = await pool.query('SELECT * FROM polls WHERE room_code=$1 AND creator_id=$2', [req.params.code, req.header('x-creator-id')]);
  if (!poll.rowCount) return res.status(403).json({ error: 'Creator access required.' });
  const candidates = await pool.query('SELECT id,name,vote_count AS votes FROM candidates WHERE poll_id=$1 ORDER BY name', [poll.rows[0].id]);
  res.json(publicPoll(poll.rows[0], candidates.rows, true));
});

app.post('/api/polls/:code/votes', async (req, res) => {
  const { candidateId, voterId } = req.body ?? {}; if (!candidateId || !voterId) return res.status(400).json({ error: 'candidateId and voterId are required.' });
  const client = await pool.connect();
  try {
    await client.query('BEGIN'); const poll = await client.query('SELECT * FROM polls WHERE room_code=$1 FOR UPDATE', [req.params.code]);
    if (!poll.rowCount) return res.status(404).json({ error: 'Poll not found.' }); const p = poll.rows[0];
    if (p.status !== 'open' || new Date(p.deadline) <= new Date()) { await client.query('ROLLBACK'); return res.status(409).json({ error: 'Voting is closed.' }); }
    const candidate = await client.query('SELECT id FROM candidates WHERE id=$1 AND poll_id=$2', [candidateId, p.id]); if (!candidate.rowCount) { await client.query('ROLLBACK'); return res.status(400).json({ error: 'Invalid candidate.' }); }
    await client.query('INSERT INTO votes(id,poll_id,candidate_id,voter_id) VALUES($1,$2,$3,$4)', [crypto.randomUUID(), p.id, candidateId, voterId]); await client.query('UPDATE candidates SET vote_count=vote_count+1 WHERE id=$1', [candidateId]); await client.query('COMMIT'); res.status(201).json({ ok: true });
  } catch (error) { await client.query('ROLLBACK'); if (error.code === '23505') return res.status(409).json({ error: 'This participant has already voted.' }); res.status(500).json({ error: 'Vote could not be recorded.' }); }
  finally { client.release(); }
});

app.post('/api/polls/:code/publish', async (req, res) => {
  const poll = await pool.query("UPDATE polls SET status='published' WHERE room_code=$1 AND creator_id=$2 RETURNING id", [req.params.code, req.body?.creatorId]);
  if (!poll.rowCount) return res.status(403).json({ error: 'Only the poll creator can publish results.' }); res.json({ ok: true });
});

app.use(express.static(path.join(root, '..', 'build', 'web')));
app.use((_req, res) => res.sendFile(path.join(root, '..', 'build', 'web', 'index.html')));

schema().then(() => app.listen(port, '0.0.0.0', () => console.log(`VoteSphere listening on ${port}`))).catch((error) => { console.error(error); process.exit(1); });
