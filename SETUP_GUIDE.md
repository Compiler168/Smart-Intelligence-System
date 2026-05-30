# 🚀 SmartLoan AI+ Complete Setup Guide

This guide walks you through setting up the entire SmartLoan AI+ project, including Firebase integration.

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Firebase Project Setup](#firebase-project-setup)
3. [Backend Configuration](#backend-configuration)
4. [Android App Configuration](#android-app-configuration)
5. [ML Service Setup](#ml-service-setup)
6. [Running the Project](#running-the-project)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before starting, ensure you have installed:

- **Node.js 18+** ([nodejs.org](https://nodejs.org))
- **Python 3.9+** ([python.org](https://python.org))
- **Android Studio** ([developer.android.com](https://developer.android.com/studio))
- **Git** ([git-scm.com](https://git-scm.com))
- **Firebase Account** (free tier available at [firebase.google.com](https://firebase.google.com))

---

## Firebase Project Setup

### Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Create a project"**
3. Enter project name: `smartloan-ai` (or your preferred name)
4. Click **"Create project"**
5. Wait for project creation to complete

### Step 2: Enable Required Services

1. In Firebase Console, go to **Build** section
2. Enable these services:
   - **Firestore Database** (select "Start in test mode" for development)
   - **Authentication** (enable Email/Password provider)
   - **Storage** (for document uploads)

### Step 3: Create Service Account Key (for Backend)

1. Go to **Project Settings** (gear icon) → **Service Accounts**
2. Click **"Generate New Private Key"**
3. A JSON file will download — this is your credentials file
4. Save it as `firebase-key.json` in the `backend/` folder
5. **⚠️ IMPORTANT**: Never commit this file. It's already in `.gitignore`.

### Step 4: Get Android Configuration File

1. In Firebase Console, click **"Add app"** → **Android**
2. Register app with package name: `com.smartloan.ai`
3. Download the `google-services.json` file
4. Place it in `android/app/google-services.json`
5. **⚠️ IMPORTANT**: Never commit this file. It's already in `.gitignore`.

### Step 5: Get Your Firebase Project Details

From Firebase Console → Project Settings:
- Copy **Project ID** (used in `.env` and backend config)
- Copy **Database URL** (optional, for Realtime Database)

---

## Backend Configuration

### Step 1: Create `.env` File

1. Go to `backend/` folder
2. Copy `.env.template` to `.env`:
   ```bash
   cp .env.template .env
   ```

3. Open `backend/.env` and fill in the values:

```bash
# Server Configuration
PORT=5000
NODE_ENV=development

# Authentication (Generate a strong random string, 32+ characters)
JWT_SECRET=your_super_secret_jwt_key_minimum_32_characters_here_change_in_production
JWT_EXPIRY=7d

# ML Service (keep as-is for local development)
ML_SERVICE_URL=http://localhost:8000

# CORS Configuration - Your Mobile App Origins
MOBILE_ORIGINS=http://10.0.2.2:5000,http://localhost:5000,http://192.168.1.100:5000

# Firebase Configuration (REQUIRED - from Firebase Console)
FIREBASE_PROJECT_ID=your-firebase-project-id-here
FIREBASE_DATABASE_URL=https://your-project.firebaseio.com

# Session Configuration
SESSION_SECRET=your_session_secret_key_change_in_production
SESSION_MAX_AGE=604800000

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=200
RATE_LIMIT_AI_MAX_REQUESTS=50

# File Upload
MAX_FILE_SIZE=10485760
ALLOWED_FILE_TYPES=pdf,doc,docx,jpg,jpeg,png
```

### Step 2: Install Backend Dependencies

```bash
cd backend
npm install
```

### Step 3: Verify Firebase Connection

The backend will automatically use the `firebase-key.json` file. Check logs during startup for:
```
✅ Firebase already initialized
✅ Service account loaded from: backend/firebase-key.json
✅ Project ID derived from service account credentials
```

---

## Android App Configuration

### Step 1: Create `local.properties`

Create `android/local.properties`:

```properties
# Android SDK Location (update to your SDK path)
sdk.dir=C:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk

# API Configuration for Development
API_BASE_URL="http://10.0.2.2:5000/api/"

# For emulator, 10.0.2.2 = localhost on your machine
# For physical device, use your PC's IP: "http://192.168.1.100:5000/api/"
```

**Note**: On Windows, use `\\` for paths. On Mac/Linux, use `/`.

### Step 2: Place `google-services.json`

1. Download `google-services.json` from Firebase Console (Step 4 above)
2. Place it exactly here: `android/app/google-services.json`
3. Verify it exists: `ls -la android/app/google-services.json`

### Step 3: Sync Gradle Files

Open Android Studio and:
1. Open `android/` folder as a project
2. Click **"File"** → **"Sync Now"**
3. Wait for Gradle sync to complete
4. Check Build Output for any errors

### Step 4: Run Android Emulator or Device

```bash
# Using Android Studio UI:
# Click "Run" → Select emulator or device → Run app

# OR from command line:
cd android
./gradlew assembleDebug  # Build APK
./gradlew installDebug   # Install on emulator/device
```

---

## ML Service Setup

### Step 1: Create Python Virtual Environment

```bash
cd ml
python -m venv venv

# Activate virtual environment:
# Windows:
venv\Scripts\activate
# Mac/Linux:
source venv/bin/activate
```

### Step 2: Install Dependencies

```bash
pip install -r requirements.txt
```

### Step 3: Start ML Service

```bash
python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

ML Service will be available at: `http://localhost:8000`

Verify by visiting: `http://localhost:8000/docs` (Swagger UI)

---

## Running the Project

### Option A: Local Development (All Services Running Locally)

**Terminal 1 - Backend:**
```bash
cd backend
npm start
# or: npm run dev  (with auto-reload)
```
✅ Backend: `http://localhost:5000`

**Terminal 2 - ML Service:**
```bash
cd ml
source venv/bin/activate  # or: venv\Scripts\activate on Windows
python -m uvicorn main:app --host 0.0.0.0 --port 8000
```
✅ ML Service: `http://localhost:8000`

**Terminal 3 - Android App:**
```bash
cd android
./gradlew assembleDebug
# Then run from Android Studio or emulator
```

**Verify Everything is Working:**
```bash
# Backend health check
curl http://localhost:5000/api/health

# ML service health check
curl http://localhost:8000/health

# Backend should show connection to ML service
curl http://localhost:5000/api/health
# Output should show: "status": "healthy"
```

### Option B: Using Docker (Recommended for Production Testing)

```bash
# Build and run entire stack
docker-compose up --build

# Services available at:
# - Backend: http://localhost:5000
# - ML: http://localhost:8000
# - MongoDB: localhost:27017
```

---

## Troubleshooting

### Backend Issues

#### Problem: `FIREBASE_PROJECT_ID is not defined`
**Solution**: 
```bash
# Make sure .env file exists and has FIREBASE_PROJECT_ID set
cat backend/.env | grep FIREBASE_PROJECT_ID

# If using service account file:
ls -la backend/firebase-key.json  # Should exist
```

#### Problem: Cannot connect to ML Service
**Solution**:
```bash
# 1. Check if ML service is running
curl http://localhost:8000/health

# 2. Check backend .env ML_SERVICE_URL
cat backend/.env | grep ML_SERVICE_URL

# 3. For Docker, use service name: http://ml:8000
```

#### Problem: Database disconnected warning
**Solution**: This is normal for development without MongoDB. For production:
```bash
# Add MongoDB connection string to .env
MONGODB_URI=mongodb+srv://user:password@cluster.mongodb.net/smartloan
```

### Android Issues

#### Problem: `google-services.json not found`
**Solution**:
```bash
# Verify file exists
ls -la android/app/google-services.json

# If missing, download from Firebase Console:
# 1. Firebase Console → Project Settings → General
# 2. Scroll to "Your Apps" section
# 3. Click Android app
# 4. Download google-services.json
```

#### Problem: Gradle sync fails
**Solution**:
```bash
# Clear Gradle cache
cd android
./gradlew clean

# Sync again
./gradlew sync
```

#### Problem: API calls fail from emulator
**Solution**: Use `10.0.2.2` instead of `localhost` in emulator:
```properties
# android/local.properties
API_BASE_URL="http://10.0.2.2:5000/api/"
```

For physical device, use your machine's IP address.

### ML Service Issues

#### Problem: Model files not found
**Solution**:
```bash
# Check if models exist
ls -la ml/models/

# If missing, train models:
cd ml
python training/train_models.py
```

#### Problem: Import errors with dependencies
**Solution**:
```bash
# Reinstall dependencies
pip install --upgrade -r requirements.txt

# Or use fresh virtual environment
rm -rf ml/venv
python -m venv ml/venv
source ml/venv/bin/activate  # or: ml\venv\Scripts\activate
pip install -r ml/requirements.txt
```

---

## Project Architecture

```
smartloan-ai/
├── android/                    # Native Android App
│   ├── app/
│   │   ├── google-services.json   # ⬅️ Firebase config (download from console)
│   │   └── build.gradle           # Configured with Google Services plugin
│   └── local.properties           # ⬅️ Build properties (API URL, SDK path)
│
├── backend/                    # Node.js/Express API
│   ├── .env                       # ⬅️ Environment variables (create from template)
│   ├── .env.template              # Template with all required variables
│   ├── firebase-key.json          # ⬅️ Service account (download from Firebase)
│   ├── src/
│   │   ├── server.js              # Express app
│   │   ├── config/firebase.js     # Firebase initialization
│   │   └── routes/                # API endpoints
│   └── package.json               # Node dependencies
│
├── ml/                         # Python ML Service
│   ├── requirements.txt        # Python dependencies
│   ├── main.py                 # FastAPI app
│   ├── services/               # ML engines
│   ├── models/                 # Trained models
│   └── venv/                   # ⬅️ Virtual environment (create with python -m venv)
│
└── README.md                   # Project documentation
```

---

## Quick Start Checklist

- [ ] Firebase project created
- [ ] Firestore Database enabled
- [ ] Authentication enabled
- [ ] Service account key downloaded → `backend/firebase-key.json`
- [ ] `google-services.json` downloaded → `android/app/google-services.json`
- [ ] `backend/.env` created from `.env.template`
- [ ] `FIREBASE_PROJECT_ID` set in `.env`
- [ ] `android/local.properties` created
- [ ] Python virtual environment created: `python -m venv ml/venv`
- [ ] All dependencies installed:
  - Backend: `npm install`
  - ML: `pip install -r requirements.txt`
- [ ] Services started and tested:
  - Backend: `npm start` → `curl http://localhost:5000/api/health`
  - ML: `python -m uvicorn main:app --host 0.0.0.0 --port 8000` → `curl http://localhost:8000/health`
  - Android: Build and run from Android Studio

---

## Getting Help

- **Firebase Docs**: [firebase.google.com/docs](https://firebase.google.com/docs)
- **Express.js Docs**: [expressjs.com](https://expressjs.com)
- **FastAPI Docs**: [fastapi.tiangolo.com](https://fastapi.tiangolo.com)
- **Android Docs**: [developer.android.com](https://developer.android.com)

---

**Last Updated**: May 30, 2026
**Project**: SmartLoan AI+ v1.0.0
