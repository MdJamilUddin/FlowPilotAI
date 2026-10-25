@echo off
setlocal
echo ============================================
echo FlowPilot AI - Windows setup
echo ============================================

where python >nul 2>nul
if errorlevel 1 (
  echo Python was not found. Install Python 3.11+ and enable Add Python to PATH.
  pause
  exit /b 1
)
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found. Install Node.js 20+ and reopen this terminal.
  pause
  exit /b 1
)

if not exist .env (
  copy .env.example .env >nul
  echo Created .env from .env.example. Edit it before production use.
)

if not exist backend\.venv (
  python -m venv backend\.venv
)
call backend\.venv\Scripts\python.exe -m pip install --upgrade pip
call backend\.venv\Scripts\python.exe -m pip install -r backend\requirements.txt
if errorlevel 1 (
  echo Backend dependency installation failed.
  pause
  exit /b 1
)

cd frontend
call npm install
if errorlevel 1 (
  echo Frontend dependency installation failed.
  cd ..
  pause
  exit /b 1
)
cd ..

echo.
echo Setup complete.
echo Edit .env, then start backend and frontend in separate terminals:
echo   set PYTHONPATH=. && backend\.venv\Scripts\python.exe -m flask --app backend.wsgi run --debug --port 5000
echo   cd frontend ^&^& npm run dev
echo.
pause
