#!/usr/bin/env bash
# SmartLoan AI+ - Start All Services (Mac/Linux)

set -e

echo "🚀 Starting SmartLoan AI+ Stack..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if port is available
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        return 0  # Port is in use
    else
        return 1  # Port is free
    fi
}

# Check prerequisites
echo "📋 Checking prerequisites..."
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js not found. Please install Node.js 18+${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js installed${NC}"

if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python 3 not found. Please install Python 3.9+${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Python 3 installed${NC}"

# Check configuration files
echo ""
echo "📁 Checking configuration files..."
if [ ! -f "backend/.env" ]; then
    echo -e "${RED}❌ backend/.env not found${NC}"
    echo "   Create it from backend/.env.template"
    exit 1
fi
echo -e "${GREEN}✅ backend/.env exists${NC}"

if [ ! -f "backend/firebase-key.json" ]; then
    echo -e "${YELLOW}⚠️  backend/firebase-key.json not found${NC}"
    echo "   Some features may not work. Get it from Firebase Console."
fi

if [ ! -f "android/app/google-services.json" ]; then
    echo -e "${YELLOW}⚠️  android/app/google-services.json not found${NC}"
    echo "   Android app will need this to build. Get it from Firebase Console."
fi

# Check ports
echo ""
echo "🔌 Checking ports..."
if check_port 5000; then
    echo -e "${YELLOW}⚠️  Port 5000 (Backend) is already in use${NC}"
else
    echo -e "${GREEN}✅ Port 5000 available${NC}"
fi

if check_port 8000; then
    echo -e "${YELLOW}⚠️  Port 8000 (ML Service) is already in use${NC}"
else
    echo -e "${GREEN}✅ Port 8000 available${NC}"
fi

# Start backend
echo ""
echo "🔧 Starting Backend (Express)..."
cd backend
if [ ! -d "node_modules" ]; then
    echo "   Installing dependencies..."
    npm install --silent
fi
npm start &
BACKEND_PID=$!
echo -e "${GREEN}✅ Backend started (PID: $BACKEND_PID)${NC}"
cd ..

# Start ML Service
echo ""
echo "🤖 Starting ML Service (FastAPI)..."
cd ml
if [ ! -d "venv" ]; then
    echo "   Creating virtual environment..."
    python3 -m venv venv
fi
source venv/bin/activate
if [ ! -d "venv/lib/python*/site-packages/fastapi" ]; then
    echo "   Installing dependencies..."
    pip install -r requirements.txt --quiet
fi
python -m uvicorn main:app --host 0.0.0.0 --port 8000 &
ML_PID=$!
echo -e "${GREEN}✅ ML Service started (PID: $ML_PID)${NC}"
cd ..

# Wait for services to start
echo ""
echo "⏳ Waiting for services to start..."
sleep 3

# Test connections
echo ""
echo "🧪 Testing connections..."
if curl -s http://localhost:5000/api/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend is responding${NC}"
else
    echo -e "${YELLOW}⚠️  Backend not responding yet${NC}"
fi

if curl -s http://localhost:8000/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ ML Service is responding${NC}"
else
    echo -e "${YELLOW}⚠️  ML Service not responding yet${NC}"
fi

# Print URLs
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}🎉 SmartLoan AI+ Stack Started!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📍 Services URLs:"
echo "   Backend:    http://localhost:5000"
echo "   ML Service: http://localhost:8000"
echo "   ML Docs:    http://localhost:8000/docs"
echo ""
echo "📊 Health Checks:"
echo "   Backend:    http://localhost:5000/api/health"
echo "   ML Service: http://localhost:8000/health"
echo ""
echo "⏹️  To stop all services:"
echo "   kill $BACKEND_PID $ML_PID"
echo ""
echo "📖 Documentation:"
echo "   - SETUP_GUIDE.md - Complete setup instructions"
echo "   - FIREBASE_SETUP.md - Firebase configuration"
echo "   - README.md - Project overview"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Keep script running
wait
