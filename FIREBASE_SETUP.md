# 🔥 Firebase Setup Instructions for SmartLoan AI+

This document explains how to get the required Firebase JSON files and integrate them with the project.

## What You Need

For the SmartLoan AI+ project to work fully, you need **two Firebase configuration files**:

1. **`google-services.json`** → Android app configuration
2. **`firebase-key.json`** → Backend server authentication

---

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **"Create a project"**
3. Name: `SmartLoan AI` (or your preference)
4. Click **"Create project"**
5. Wait for the project to be created
6. Click **"Continue"**

---

## Step 2: Enable Required Firebase Services

### Enable Firestore Database
1. In Firebase Console, go to **Build** → **Firestore Database**
2. Click **"Create database"**
3. Select **"Start in test mode"** (for development)
4. Click **"Create"**
5. Choose your location (closest to you)
6. Click **"Enable"**

### Enable Authentication
1. Go to **Build** → **Authentication**
2. Click **"Get started"**
3. Click **"Email/Password"**
4. Enable the toggle
5. Click **"Save"**

### Enable Cloud Storage (for document uploads)
1. Go to **Build** → **Storage**
2. Click **"Get started"**
3. Click **"Start in test mode"**
4. Select your location
5. Click **"Done"**

---

## Step 3: Download Android Configuration File (google-services.json)

### Get Your Firebase Project ID First:
1. In Firebase Console, click **⚙️ Project Settings** (gear icon)
2. Go to **General** tab
3. Copy your **Project ID** (example: `smartloan-ai-abc123`)
4. **You'll use this later**

### Download google-services.json:
1. Still in Firebase Console
2. Click **"Add app"** button
3. Select **Android**
4. Enter:
   - **Android package name**: `com.smartloan.ai`
   - **App nickname**: `SmartLoan Android`
   - **Debug signing certificate SHA-1** (optional, leave blank for now)
5. Click **"Register app"**
6. Click **"Download google-services.json"**
7. A JSON file will download

### Place the File:
```bash
# Copy the downloaded file to:
android/app/google-services.json
```

**Verify it exists:**
```bash
ls -la android/app/google-services.json  # Should show the file
```

---

## Step 4: Download Backend Service Account Key (firebase-key.json)

### Generate Service Account Key:
1. In Firebase Console, go to **⚙️ Project Settings** → **Service Accounts**
2. Select **Firebase Admin SDK** tab
3. Make sure **Node.js** is selected
4. Click **"Generate New Private Key"**
5. A JSON file will download — this is your **firebase-key.json**

### Place the File:
```bash
# Copy the downloaded file to:
backend/firebase-key.json
```

**Verify it exists:**
```bash
ls -la backend/firebase-key.json  # Should show the file
```

**⚠️ IMPORTANT**: 
- Never commit this file (it's in `.gitignore`)
- Never share this file publicly
- This contains your Firebase credentials

---

## Step 5: Update Backend Configuration

### Update FIREBASE_PROJECT_ID in backend/.env:

1. Open `backend/.env`
2. Find this line:
   ```
   FIREBASE_PROJECT_ID=smartloan-ai-demo
   ```
3. Replace `smartloan-ai-demo` with your actual Firebase Project ID (from Step 3)
4. Save the file

**Example:**
```bash
FIREBASE_PROJECT_ID=smartloan-ai-xyz789
```

---

## Step 6: Verify Setup is Complete

Run these checks:

### Check Android Configuration:
```bash
# Should exist and contain your Firebase config
cat android/app/google-services.json | head -5
```

### Check Backend Configuration:
```bash
# Should exist and contain your Firebase credentials
cat backend/firebase-key.json | head -5

# Should have your project ID
cat backend/.env | grep FIREBASE_PROJECT_ID
```

### Test Backend Connection:
```bash
cd backend
npm start
# Look for: ✅ Firebase already initialized
# or: ✅ Service account loaded from: backend/firebase-key.json
```

---

## File Checklist

- [ ] `android/app/google-services.json` exists (downloaded from Firebase)
- [ ] `backend/firebase-key.json` exists (downloaded from Firebase)
- [ ] `backend/.env` has correct `FIREBASE_PROJECT_ID`
- [ ] `backend/.env` has `JWT_SECRET` set
- [ ] `android/local.properties` has correct `sdk.dir`
- [ ] ML Service configured (requirements.txt installed)

---

## Common Issues & Solutions

### Error: "FIREBASE_PROJECT_ID is not defined"
**Solution:**
```bash
# Check if it's in .env
cat backend/.env | grep FIREBASE_PROJECT_ID

# Make sure it matches your actual Firebase project ID
# Go to Firebase Console > Project Settings > General to verify
```

### Error: "Cannot find google-services.json"
**Solution:**
```bash
# File must be at this exact path:
android/app/google-services.json

# Download again from:
# Firebase Console > Project Settings > Your Apps > Android
```

### Error: "Cannot read firebase-key.json"
**Solution:**
```bash
# File must be at this exact path:
backend/firebase-key.json

# Make sure it exists:
ls -la backend/firebase-key.json

# Check file permissions:
chmod 644 backend/firebase-key.json  # Mac/Linux
```

### Database shows "disconnected"
**This is normal in development without MongoDB.** The app works fine. For production, add MongoDB:
```bash
# In backend/.env, add:
MONGODB_URI=mongodb+srv://user:password@cluster.mongodb.net/smartloan
```

---

## Next Steps

After completing the setup:

1. **Start the Backend:**
   ```bash
   cd backend
   npm start
   ```

2. **Start the ML Service:**
   ```bash
   cd ml
   source venv/bin/activate  # or: venv\Scripts\activate (Windows)
   python -m uvicorn main:app --host 0.0.0.0 --port 8000
   ```

3. **Build & Run Android App:**
   ```bash
   cd android
   ./gradlew assembleDebug
   # Or run from Android Studio
   ```

4. **Test the Connections:**
   ```bash
   # Backend health
   curl http://localhost:5000/api/health
   
   # ML health
   curl http://localhost:8000/health
   ```

---

## Firebase Console Reference

| Feature | Path |
|---------|------|
| Project ID | ⚙️ Settings → General |
| android/app/google-services.json | ⚙️ Settings → General → Your Apps → Android → Download |
| backend/firebase-key.json | ⚙️ Settings → Service Accounts → Firebase Admin SDK → Generate |
| Firestore Database | Build → Firestore Database |
| Authentication | Build → Authentication |
| Storage | Build → Storage |

---

## Support

- **Firebase Docs**: https://firebase.google.com/docs
- **Android with Firebase**: https://firebase.google.com/docs/android/setup
- **Server Setup**: https://firebase.google.com/docs/admin/setup

---

**Last Updated**: May 30, 2026
**Project**: SmartLoan AI+ v1.0.0
