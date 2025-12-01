#!/bin/bash

# Task Management App Deployment Script
# This script helps prepare your app for deployment

echo "🚀 Task Management App Deployment Preparation"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root."
    exit 1
fi

print_info "Checking project structure..."

# Check for required files
if [ -f "vercel.json" ]; then
    print_status "vercel.json found"
else
    print_warning "vercel.json not found"
fi

if [ -f "render.yaml" ]; then
    print_status "render.yaml found"
else
    print_warning "render.yaml not found"
fi

if [ -f ".env" ]; then
    print_status ".env file found"
else
    print_error ".env file not found - you'll need this for local development"
fi

print_info "Installing frontend dependencies..."
npm install

if [ $? -eq 0 ]; then
    print_status "Frontend dependencies installed"
else
    print_error "Failed to install frontend dependencies"
    exit 1
fi

print_info "Installing backend dependencies..."
cd server && npm install

if [ $? -eq 0 ]; then
    print_status "Backend dependencies installed"
else
    print_error "Failed to install backend dependencies"
    exit 1
fi

cd ..

print_info "Building frontend..."
npm run build

if [ $? -eq 0 ]; then
    print_status "Frontend build successful"
else
    print_error "Frontend build failed"
    exit 1
fi

print_info "Building backend..."
cd server && npm run build

if [ $? -eq 0 ]; then
    print_status "Backend build successful"
else
    print_error "Backend build failed"
    exit 1
fi

cd ..

echo ""
echo "🎉 Deployment preparation complete!"
echo ""
echo "Next steps:"
echo "=========="
echo "1. 📁 Push your code to GitHub"
echo "2. 🌐 For Vercel + Render deployment:"
echo "   - Deploy backend to Render using render.yaml"
echo "   - Deploy frontend to Vercel"
echo "   - Update environment variables"
echo ""
echo "3. 🔧 For full Vercel deployment:"
echo "   - Create API functions in /api directory"
echo "   - Deploy to Vercel with serverless functions"
echo ""
echo "4. 🔐 Environment variables needed:"
echo "   Frontend (Vercel):"
echo "   - VITE_API_URL"
echo ""
echo "   Backend (Render):"
echo "   - MONGODB_URI"
echo "   - JWT_SECRET"
echo "   - JWT_EXPIRES_IN"
echo "   - NODE_ENV"
echo ""
echo "📖 See DEPLOYMENT.md for detailed instructions"
echo ""

# Check Git status
if git status &>/dev/null; then
    print_info "Git repository detected"
    
    if [ -n "$(git status --porcelain)" ]; then
        print_warning "You have uncommitted changes. Consider committing them before deployment."
        git status --short
    else
        print_status "Working directory is clean"
    fi
else
    print_warning "Not a Git repository. You'll need to initialize Git and push to GitHub for deployment."
    echo "Run: git init && git add . && git commit -m 'Initial commit'"
fi

echo ""
echo "🚀 Ready for deployment!"
