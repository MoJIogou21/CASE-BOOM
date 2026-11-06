# CASE BOOM — mobile starter

A cross-platform Android/iOS case-opening simulator built without a game engine.
Client: Flutter/Dart. Backend starter: Node.js + Express + PostgreSQL.

## Included
- Flutter app shell with dark CASE BOOM visual identity
- Home, Cases, Inventory, Shop and Profile navigation
- Local demo case-opening flow with animated roulette
- Demo-only virtual coin balance and inventory state
- Node.js API skeleton and PostgreSQL schema
- Server-side opening endpoint placeholder (production probability logic must remain server-side)

## Requirements
- Flutter stable SDK
- Android Studio / Xcode for platform builds
- Node.js 20+
- PostgreSQL 15+

## Run the mobile app
```bash
cd mobile
flutter create . --platforms=android,ios
flutter pub get
flutter run
```
The starter uses Flutter SDK widgets only. No game engine is included.

## Run the API
```bash
cd server
cp .env.example .env
npm install
npm run dev
```
Create a PostgreSQL database and apply `schema.sql`. Configure `DATABASE_URL`.
The included API is a development scaffold, not production-ready authentication or economy security.

## Important product boundaries
- All balances and items in this starter are virtual, non-redeemable game data.
- No Steam inventory connection, cash-out, betting, or real-money item trading.
- Use only assets you own or are licensed to use. CS2 names, logos, weapon artwork and case artwork may be protected by Valve or third parties. Obtain permission or use original placeholder artwork before public release.
- Production opening results must be generated and recorded on the server; never trust a client-provided winning item.


## Android phone workflow (Stage 2)
See `docs/ANDROID_PHONE_SETUP_RU.md`. GitHub Actions builds a debug APK in the cloud. The workflow generates Android platform files, runs `flutter analyze`, and uploads the APK artifact.
