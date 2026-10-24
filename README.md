# GovNexus — Full-stack governance workflow platform

GovNexus is a Flask + SQLAlchemy application with a responsive HTML/CSS/JavaScript frontend and a relational database. It provides role-based workspaces for administrators, officers, and applicants.

## Included functionality

- Secure password hashing and session-based authentication
- Officer and applicant registration
- Admin bootstrap account from environment variables; additional admins can be created from the admin workspace
- Officer task tracking, progress updates, notes, and completion certificates (PDF)
- Transfer requests and leave/resignation applications
- Job openings, applicant submissions, admin review, and offer-letter PDFs after approval
- Admin dashboard, task assignment, people directories, request review, recruitment management, and activity logs
- JSON endpoints for core workflows
- File-upload extension validation and size limit
- Responsive interface with reduced-motion support

## 1. Requirements

- Python 3.10+
- MySQL 8+ (recommended for shared data), or SQLite for a quick local test
- Visual Studio Code is optional

## 2. Set up on Windows

Open a terminal in the `GovNexus` folder:

```powershell
python -m venv venv
venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt
copy .env.example .env
```

Open `.env` and change `SECRET_KEY` and `BOOTSTRAP_ADMIN_PASSWORD`. The bootstrap admin is created only if both bootstrap variables are set and that username does not already exist. Do not deploy using the example password.

For a quick local test, the default SQLite configuration is sufficient. Start the app:

```powershell
python run.py
```

Open `http://127.0.0.1:5000`.

Sign in as the bootstrap administrator using the username and password you configured in `.env`. The application does not display credentials on the login page.

## 3. Configure MySQL

1. Start your MySQL server.
2. Create a database named `govnexus` (you may run `database.sql` in MySQL Workbench).
3. Create a dedicated MySQL user and grant it access to the `govnexus` database.
4. In `.env`, set `DATABASE_URL` in this format:

```text
DATABASE_URL=mysql+pymysql://govnexus_user:URL_ENCODED_PASSWORD@localhost/govnexus?charset=utf8mb4
```

If the password contains special characters, URL-encode them. Restart `python run.py`; SQLAlchemy creates the application tables on startup. For deployments, use migrations and backups rather than relying only on automatic table creation.

## 4. Local network testing

This lets other devices on the same Wi-Fi access the same running instance and database; it is not public internet hosting.

1. In PowerShell, set `HOST=0.0.0.0` for the terminal session:

```powershell
$env:HOST="0.0.0.0"
python run.py
```

2. Find the computer's private IPv4 address with `ipconfig` (for example, `192.168.1.25`).
3. On another device connected to the same network, open `http://192.168.1.25:5000`.
4. If Windows Firewall asks, allow access only on a trusted private network.

Do not expose Flask's development server directly to the public internet. For public deployment, use a production WSGI server, HTTPS, secure environment variables, managed MySQL, restricted uploads, backups, and a deployment platform.

## 5. Uploads and generated PDFs

Officer offer-letter uploads accept PDF, JPG, JPEG, and PNG. Files are saved under `app/static/uploads`; generated certificates and offer letters are saved under `app/static/generated`. Keep these folders private in production and use protected download routes or private object storage for sensitive documents. The demo validates extensions and enforces a size limit, but production should also inspect file contents and apply malware scanning.

## 6. API examples

Most APIs require a logged-in session. JSON responses use `application/json`.

- `POST /api/login`
- `POST /api/officer/register` (HTML form is the supported upload registration route)
- `POST /api/applicant/register` (registration form is available at `/register/applicant`)
- `GET /api/officers` (admin)
- `GET /api/applicants` (admin)
- `GET|POST /api/tasks`
- `PATCH /api/tasks/<id>`
- `GET|POST /api/transfers`
- `PATCH /api/transfers/<id>` (admin)
- `GET|POST /api/applications`
- `PATCH /api/applications/<id>` (admin)
- `GET|POST /api/jobs`
- `PATCH /api/jobs/<id>` (admin)
- `GET /api/activity-logs` (admin)

## 7. Demo and production notes

This project does not insert fake users or fake operational records. Register real test accounts through the forms and create tasks/openings through the admin dashboard.

This is a functional starter application, not a certified government information system. Before real use, add CSRF protection, rate limiting, password reset and email verification, audit-log hardening, stronger file-content validation, database migrations, automated tests, backup/restore procedures, and a production deployment configuration. Use a unique high-entropy `SECRET_KEY`; do not commit `.env` or uploaded documents to Git.
