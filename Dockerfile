# syntax=docker/dockerfile:1

FROM ghcr.io/cirruslabs/flutter:3.47.7 AS build
WORKDIR /app

COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

FROM node:22-alpine
WORKDIR /app
COPY backend/package.json ./backend/package.json
RUN cd backend && npm install --omit=dev
COPY backend ./backend
COPY --from=build /app/build/web ./build/web
ENV NODE_ENV=production
EXPOSE 10000
CMD ["node", "backend/server.js"]
