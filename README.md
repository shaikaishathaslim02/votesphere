# VoteSphere

VoteSphere is a Flutter Web voting-poll demo with a Render-ready Node/Express API and PostgreSQL schema.

## Local demo

```powershell
flutter pub get
flutter run -d chrome
```

The app uses the Render API when deployed. If the API is unavailable during local development, it falls back to local demo mode.

## Deploy to Render with PostgreSQL

1. Push this project to a Git provider and connect the repository in Render.
2. Choose **New > Blueprint** and select the repository containing `render.yaml`.
3. Render creates the `votesphere` Docker web service and `votesphere-db` PostgreSQL database.
4. Confirm the generated `DATABASE_URL` environment variable is present on the web service, then deploy.
5. Check `/api/health` on the deployed URL. It should return `{ "ok": true }`.

The Docker image builds the Flutter site, starts the API on Render's `PORT`, and serves both from the same web service. The API keeps PostgreSQL credentials server-side. Because Flutter and the API share one origin in production, no public database URL is exposed to the browser.

The API endpoints are in `backend/server.js`: create poll, find poll, submit vote, publish results, and health check. Before using this as a real election system, add authentication, rate limiting, audit logging, and production creator/participant identity management.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
