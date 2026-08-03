# Connecting Miz to a new Supabase project

Related: [`docs/SECURITY.md`](SECURITY.md), [`docs/DATABASE.md`](DATABASE.md), [`docs/DEPLOYMENT.md`](DEPLOYMENT.md).

Miz already contains `supabase_flutter`, validated build-time configuration, and initialization in `bootstrap.dart`. Switching projects does not require replacing `main.dart`, creating a demo screen, or creating a second local database.

## 1. Create or select the project

Create the project in the Supabase Dashboard and wait until it is healthy. A Supabase project already includes its Postgres database; do not create a separate database just to connect Flutter.

In the project's **Connect** dialog, copy these two client-safe values:

| Miz setting | Supabase value | Example shape |
|---|---|---|
| `SUPABASE_URL` | Project URL | `https://project-ref.supabase.co` |
| `SUPABASE_PUBLISHABLE_KEY` | Publishable key | `sb_publishable_...` |

The same publishable key is available under **Project Settings → API Keys**. Prefer the current publishable key over the legacy JWT-shaped `anon` key.

Never add any of these to Flutter, `.env.json`, source control, screenshots, or chat:

- Secret key (`sb_secret_...`)
- Legacy `service_role` key
- Database password or connection string
- JWT signing secret

Those values are for trusted server infrastructure only and can bypass normal client protections.

## 2. Add the local values

The one-time preparation command is:

```bash
cp .env.example.json .env.json
```

Then edit the git-ignored `.env.json`:

```json
{
  "SUPABASE_URL": "https://YOUR_PROJECT_REF.supabase.co",
  "SUPABASE_PUBLISHABLE_KEY": "sb_publishable_YOUR_KEY"
}
```

If `.env.json` already points at an older project, replace both values together. Do not commit the file. The application intentionally rejects partial configuration and non-HTTPS URLs.

## 3. Verify before running

The verifier reads the local file, calls the project's public Auth settings endpoint, and never prints the key:

```bash
dart run tool/verify_supabase_config.dart
```

Then launch or build with the same file:

```bash
flutter run --dart-define-from-file=.env.json
flutter build apk --debug --dart-define-from-file=.env.json
```

Running `flutter run` without the `--dart-define-from-file` flag intentionally starts Miz with its local/mock adapters and does not initialize Supabase.

## 4. Required Dashboard security settings

Connecting the SDK does not authorize database access. Before wiring any Miz repository to a table:

1. Create the table through a checked-in migration.
2. Enable Row Level Security on the table.
3. Add explicit policies for only the required `anon` or `authenticated` operations.
4. Confirm writes are denied to the client for backend-managed catalog tables.
5. Run Supabase's Security Advisor and resolve relevant findings.

The target table and policy design is documented in `docs/DATABASE.md`. Do not create a generic `todos` table; it belongs only to Supabase's quick-start example and is unrelated to Miz.

## 5. Auth, Storage, and Realtime

These settings are feature-dependent and should not be enabled speculatively:

- **Authentication:** Email/password, magic links, OAuth providers, redirect URLs, and mobile deep links are configured when Miz's Auth milestone is implemented. The current `com.example...` bundle/application identifiers must be replaced with production identifiers before OAuth or email-link redirects are registered.
- **Storage:** Create private buckets by default. Add bucket policies for the exact authenticated user or backend workflow before uploading profile or camera data. Never make user uploads public as a shortcut.
- **Realtime:** Add only tables that genuinely need live updates to the Realtime publication. Ordinary restaurant/catalog reads do not require Realtime.
- **Edge Functions:** Keep secret keys in Supabase function secrets. Never pass them through Flutter defines.

## 6. Staging and production

Use separate Supabase projects and separate CI secret values for staging and production. CI must provide `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` at build time. Never reuse production data in a development project.

## Current connection boundary

`bootstrap.dart` initializes the selected project, but Miz's presentation layer still uses typed local/mock repositories. A feature becomes remotely backed only after its repository implementation, typed row parsing, failure mapping, migrations, and RLS tests are completed. This prevents a valid connection from being mistaken for a production-ready backend.
