@echo off
REM SmartLoan AI+ - Start All Services (Windows)
setlocal enabledelayedexpansion

echo.
echo ========================================
echo  SmartLoan AI+ - Starting All Services
echo ========================================
echo.

REM Check for Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js not found. Please install Node.js 18+
    pause
    exit /b 1
)
echo [OK] Node.js is installed

REM Check for Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python not found. Please install Python 3.9+
    pause
    exit /b 1
)
echo [OK] Python is installed

REM Check configuration files
echo.
echo Checking configuration files...
if not exist "backend\.env" (
    echo [ERROR] backend\.env not found
    echo Create it from backend\.env.template
    pause
    exit /b 1
)
echo [OK] backend\.env exists

if not exist "backend\firebase-key.json" (
    echo [WARNING] backend\firebase-key.json not found
    echo Get it from Firebase Console
)

if not exist "android\app\google-services.json" (
    echo [WARNING] android\app\google-services.json not found
    echo Get it from Firebase Console
)

REM Start Backend
echo.
echo Starting Backend (Express.js)...
cd backend
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install --silent
)
start "SmartLoan Backend" cmd /k npm start
cd ..
timeout /t 3 /nobreak
echo [OK] Backend started on port 5000

REM Start ML Service
echo.
echo Starting ML Service (FastAPI)...
cd ml
if not exist "venv" (
    echo Creating Python virtual environment...
    python -m venv venv
)
call venv\Scripts\activate.bat
if not exist "venv\Lib\site-packages\fastapi" (
    echo Installing dependencies...
    pip install -r requirements.txt -q
)
start "SmartLoan ML Service" cmd /k python -m uvicorn main:app --host 0.0.0.0 --port 8000
cd ..
timeout /t 3 /nobreak
echo [OK] ML Service started on port 8000

REM Test connections
echo.
echo Testing connections...
timeout /t 2 /nobreak

echo.
echo ========================================
echo  Services Started Successfully!
echo ========================================
echo.
echo Backend:    http://localhost:5000
echo ML Service: http://localhost:8000
echo ML Docs:    http://localhost:8000/docs
echo.
echo Health Checks:
echo   curl http://localhost:5000/api/health
echo   curl http://localhost:8000/health
echo.
echo Press any key to continue...
pause >nul
