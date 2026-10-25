# FlowPilot AI — bilingual AI automation starter

A founder-friendly MVP with:
- React + Vite frontend (Bangla/English)
- Flask API, SQLAlchemy, PostgreSQL-ready configuration
- Session authentication, password hashing, CSRF protection
- Contact lead capture and admin lead list
- AI workflow endpoint (real provider integration is optional)
- Docker deployment with one web container + PostgreSQL

## Important security/setup notes
- This is an MVP starter, not a completed security audit.
- Set a long random `SECRET_KEY` in production.
- Set `BOOTSTRAP_ADMIN_EMAIL` and `BOOTSTRAP_ADMIN_PASSWORD` before first launch.
- Change the bootstrap password immediately after first login; the current MVP does not include password-change UI.
- Do not commit `.env` or production secrets.
- AI requests are only enabled when `OPENAI_API_KEY` is configured. Review provider terms and avoid sending sensitive personal data.
- Set `COOKIE_SECURE=1` when serving HTTPS in production.
- The app applies CSRF protection to state-changing API requests.
- For production use, add email verification, password reset, login throttling, monitoring, backups, privacy policy, and a security review.

## Local development (Windows 11)
Requirements: Python 3.11+ and Node.js 20+.

1. Copy `.env.example` to `.env` and fill the required values.
2. Run `setup.bat`.
3. In one terminal: `cd backend` then `python -m flask --app wsgi run --debug`
4. In another terminal: `cd frontend` then `npm run dev`
5. Open http://localhost:5173

Vite proxies `/api` requests to Flask at http://127.0.0.1:5000.

## First admin
The admin is created on the first backend startup only if both bootstrap variables are set. Keep those credentials private. If you need to reset local data, remove the SQLite database file and restart; do not do this to production data.

## Docker deployment
1. Copy `.env.example` to `.env` and set secure production values.
2. Ensure `DATABASE_URL` is set to `postgresql+psycopg://flowpilot:CHANGE_ME@db:5432/flowpilot` for Compose (the compose file overrides it).
3. Run `docker compose -f deployment/docker-compose.yml up --build -d`
4. Visit http://localhost:8000.
5. For public launch, put the app behind a managed HTTPS reverse proxy or deploy the container to a platform that provides HTTPS. Set `COOKIE_SECURE=1` when HTTPS is active.

## Suggested launch stages
1. Verify contact form, login and dashboard locally.
2. Add automated tests and password reset/email verification.
3. Deploy a staging instance and verify HTTPS, cookies, backups and logs.
4. Add a privacy policy, terms, service scope and customer consent before collecting real customer data.
5. Only then onboard paying clients.
