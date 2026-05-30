# Smart Intelligence System

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/Compiler168/Smart-Intelligence-System/ci-and-deploy.yml?branch=main)
![License](https://img.shields.io/github/license/Compiler168/Smart-Intelligence-System)
![Last Commit](https://img.shields.io/github/last-commit/Compiler168/Smart-Intelligence-System)

## Project Introduction

**Project Name:** Smart Intelligence System

**Tagline:** AI-powered loan analytics, risk evaluation, and financial advisory for modern Android users.

**Executive Summary:**
Smart Intelligence System is a mobile-first fintech platform that combines a native Android client, a secure Express.js backend, and a dedicated FastAPI AI/ML microservice. The system delivers loan approval scoring, credit health analytics, risk assessment, NLP-based financial assistance, and report generation in a cohesive architecture.

**Project Overview:**
The platform brings together:
- Native Android application built with Java and Android Jetpack.
- Express.js backend API with Firebase Firestore persistence.
- Python FastAPI ML service for loan prediction, risk scoring, simulation, NLP chat, and document analysis.
- Clean project organisation, container-friendly deployment, and secure developer workflows.

---

## Business Documentation

### Problem Statement
Many borrowers and financial advisors need better real-time insight into loan eligibility, credit health, and risk exposure. Existing tools often provide only generic recommendation without machine learning-backed analytics or an integrated mobile experience.

### Existing Challenges
- Disconnected loan advice across platforms.
- Limited real-time probability scoring.
- Lack of explainable financial health and risk analysis.
- Poor integration between mobile experience and backend intelligence.

### Proposed Solution
Smart Intelligence System centralizes loan prediction, credit health evaluation, risk analytics, and AI-driven advisory into a single Android-native fintech workflow.

### Benefits
- Faster and more accurate loan decision support.
- Personalized financial insights based on user profile and credit factors.
- Reduced risk through predictive analytics.
- Secure and scalable backend architecture.
- Mobile-first experience with enterprise-quality documentation.

### Objectives
- Deliver loan probability scoring and approval recommendation.
- Support financial health scoring and risk analysis.
- Provide secure authentication and session management.
- Build a reusable AI/ML microservice architecture.
- Keep the repository professional, maintainable, and deployment-ready.

### Target Users
- Loan applicants seeking accurate approval insight.
- Financial advisors needing intelligent decision support.
- Mobile-first consumers in emerging markets.
- Product teams validating AI-enabled fintech workflows.

---

## Technical Documentation

### Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| Android | Java, Android Jetpack | Native mobile UI and local persistence |
| Backend | Node.js, Express.js | REST API, authentication, Firestore integration |
| Database | Firebase Firestore | Secure cloud persistence for users, predictions, chats, and reports |
| AI/ML Service | Python, FastAPI | Loan prediction, health scoring, risk analysis, NLP, simulation |
| Containerization | Docker | Standardized service packaging for backend and ML service |

### System Architecture

```
Android App (Java)
   ↕ HTTPS
Express Backend (Node.js)
   ↕ HTTP
FastAPI ML Service (Python)
   ↕ Firestore
Firebase Firestore Database
```

### Frontend Architecture
- Native Android application using Java and Android Jetpack.
- UI flows built with Activity/Fragment patterns and ViewModels.
- REST API connectivity with JWT authentication and secure session handling.
- Local persistence using Room and cached UI state.

### Backend Architecture
- `backend/src/server.js` bootstraps Express, security middleware, and routes.
- Separate route modules for authentication, loans, financial analytics, chat, and reports.
- Firestore integration through backend configuration and model classes.
- JWT middleware protects API endpoints.
- ML service calls are proxied through Axios.

### Database Architecture
- Firebase Firestore stores key collections for application data.
- Primary collections include:
  - `users`
  - `predictions`
  - `analyses`
  - `chatSessions`
  - `reports`
  - `dashboards`

### Machine Learning Architecture
- `ml-service/main.py` exposes a FastAPI ML service.
- Modular engines handle prediction, health scoring, risk analysis, NLP chat, simulation, and document parsing.
- Models include XGBoost, random forest, and logistic regression.
- Lazy-loaded engines optimize startup performance.

### Security Architecture
- JWT-based authentication for protected routes.
- Password hashing with `bcryptjs`.
- Helmet for HTTP security headers.
- CORS restrictions configured from environment variables.
- Rate limiting for general and AI-specific endpoints.
- Local secret management using `.env` and ignored credential files.

---

## Feature Documentation

### User Features

#### Registration and Login
- Purpose: Secure user onboarding and authentication.
- Inputs: `name`, `email`, `password`.
- Processing Logic: Hashes passwords, stores user data, issues JWT.
- Outputs: Auth token and profile details.
- Implementation: `backend/src/controllers/AuthController.js`, `backend/src/routes/auth.js`.

#### Profile Management
- Purpose: Capture user financial profile for accurate analytics.
- Inputs: income, expenses, credit score, employment details.
- Processing Logic: Updates Firestore user records and refreshes analytics.
- Outputs: Updated profile and health metrics.
- Implementation: `AuthController.updateProfile`.

#### Loan Prediction
- Purpose: Estimate loan approval probability using ML.
- Inputs: financial profile and loan request.
- Processing Logic: Sends data to the ML service and stores prediction results.
- Outputs: Probability score, approval recommendation, and risk factors.
- Implementation: `LoanController.predictLoan`, `ml-service/services/prediction_engine.py`.

#### Financial Dashboard
- Purpose: Show financial health and loan analytics.
- Inputs: authenticated user session.
- Processing Logic: Aggregates Firestore metrics and refreshes dashboard state.
- Outputs: Metrics, scores, and summaries.
- Implementation: `FinancialController.getDashboard`.

#### AI Chat Assistant
- Purpose: Provide conversational financial guidance.
- Inputs: chat message, session ID, user data.
- Processing Logic: Uses NLP engine for intent handling and response generation.
- Outputs: Chat replies and session history.
- Implementation: `ChatController.sendMessage`, `ml-service/services/nlp_engine.py`.

### AI Features

#### Loan Prediction Engine
- Purpose: Generate explainable loan approval predictions.
- Inputs: borrower profile, loan application details.
- Processing Logic: Feature preprocessing, ensemble model inference, factor explanation.
- Outputs: probability score, confidence, and risk observations.
- Implementation: `PredictionEngine.predict`.

#### Health Scoring
- Purpose: Measure financial health using user metrics.
- Inputs: income, expenses, savings, credit score, debts.
- Processing Logic: ML scoring and classification.
- Outputs: health score and risk tier.
- Implementation: `HealthScorer`.

#### Risk Analysis
- Purpose: Assess loan risk relative to current financial position.
- Inputs: credit profile and proposed loan terms.
- Processing Logic: Risk model calculations and recommendation generation.
- Outputs: risk rating and mitigation advice.
- Implementation: `RiskAnalyzer`.

#### Simulation Engine
- Purpose: Model future loan scenarios and cash-flow impact.
- Inputs: income, expenses, loan variables, projection parameters.
- Processing Logic: Forecasts balances and scenarios.
- Outputs: projection summary and recommendations.
- Implementation: `SimulationEngine`.

### Analytics Features
- Purpose: Store prediction history, analysis records, and generated reports.
- Inputs: authenticated user actions.
- Processing Logic: Firestore persistence and retrieval.
- Outputs: historical analytics and records.
- Implementation: Firestore models under `backend/src/models`.

### Security Features
- Purpose: Protect user data and API endpoints.
- Inputs: JWT tokens, request headers.
- Processing Logic: Token verification, rate limiting, input validation.
- Outputs: authorized access or rejection.
- Implementation: `backend/src/middleware/auth.js`, `helmet`, and rate limiting.

### Administrative Features
- Purpose: Seed demo data and verify service health.
- Inputs: backend startup.
- Processing Logic: Checks Firestore connectivity and adds a demo admin user if needed.
- Outputs: seeded demo account and health status.
- Implementation: `backend/src/server.js`.

---

## Project Structure

```
Smart-Intelligence-System/
├── android/                    # Native Android application
│   ├── app/
│   │   ├── build.gradle
│   │   ├── src/
│   │   │   ├── main/
│   │   │   │   ├── java/com/smartloan/ai/  # Java source code
│   │   │   │   ├── res/                    # UI resources
│   │   │   │   └── AndroidManifest.xml
│   │   │   ├── test/                      # Unit tests
│   │   │   └── androidTest/               # Instrumented tests
│   │   ├── google-services.json          # Firebase config (local only)
│   │   └── proguard-rules.pro
│   ├── gradle/
│   ├── settings.gradle
│   └── gradle.properties
├── backend/                    # Express.js API backend
│   ├── src/
│   │   ├── server.js
│   │   ├── config/
│   │   │   └── firebase.js
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── models/
│   │   └── routes/
│   ├── package.json
│   └── firebase-key.json          # Local service account credentials
├── ml-service/                 # FastAPI ML microservice
│   ├── main.py
│   ├── requirements.txt
│   ├── Dockerfile
│   ├── services/
│   ├── models/
│   └── training/
├── eda/                        # Exploratory data analysis artifacts
│   ├── data/
│   └── analysis/
├── .github/                    # GitHub workflows and automation
├── .gitignore
├── DEPLOYMENT.md
├── ARCHITECTURE.md
├── DesignSystem.md
└── LICENSE
```

---

## Quick Start (Local Development)

### Prerequisites
- Node.js 18+ (backend)
- Python 3.8+ (ML service)
- Java JDK and Android Studio
- Firebase account or Firestore access
- Git

### 1. Backend Setup

```bash
cd backend
npm install
```

Create a `.env` file inside `backend/` with values similar to:

```env
PORT=5000
NODE_ENV=development
FIREBASE_PROJECT_ID=your-firebase-project-id
GOOGLE_APPLICATION_CREDENTIALS=./firebase-key.json
JWT_SECRET=your_jwt_secret
ML_SERVICE_URL=http://localhost:8000
MOBILE_ORIGINS=http://localhost:5000,http://127.0.0.1:5000
```

Start the backend:

```bash
npm run dev
```

### 2. ML Service Setup

```bash
cd ../ml-service
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### 3. Android App Setup

Open `android/` in Android Studio and configure your local SDK.
Ensure `android/app/google-services.json` is added locally if Firebase features are required.

---

## Deployment

### Backend
- Build and deploy using the provided `backend/Dockerfile`.
- Use production environment values for Firebase and JWT settings.

### ML Service
- Build from `ml-service/Dockerfile`.
- Ensure model files are present in `ml-service/models/`.

### Android
- Build release APK from Android Studio.
- Configure API endpoint references in the app if deployment targets change.

---

## API Reference

### Backend
- `POST /api/auth/register` - Register new users.
- `POST /api/auth/login` - Authenticate existing users.
- `POST /api/loans/predict` - Generate loan approval predictions.
- `POST /api/financial/dashboard` - Fetch financial analytics.
- `POST /api/chat` - Send a message to the AI assistant.
- `POST /api/reports` - Generate or retrieve reports.

### ML Service
- `POST /predict` - Loan prediction.
- `POST /health-score` - Health scoring.
- `POST /risk-analysis` - Risk evaluation.
- `POST /chat` - NLP chat assistance.
- `POST /simulate` - Financial scenario simulation.
- `POST /analyze-document` - Document parsing.

---

## Environment Variables

### Backend
- `PORT`
- `NODE_ENV`
- `FIREBASE_PROJECT_ID`
- `GOOGLE_APPLICATION_CREDENTIALS`
- `JWT_SECRET`
- `ML_SERVICE_URL`
- `MOBILE_ORIGINS`

### ML Service
- No required environment variables by default; use local FastAPI defaults.

---

## Testing

### Backend
- Run backend tests if implemented under `backend/src/test` or add test coverage as needed.

### ML Service
- Run:

```bash
cd ml-service
pytest
```

---

## Demo Credentials
- Email: `demo@smartloan.ai`
- Password: `demo123`

---

## License

This repository is licensed under the terms of the `LICENSE` file.
