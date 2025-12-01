#!/bin/bash

# Environment Setup Script for Task Management App
# This script helps you set up environment variables for development and deployment

echo "🔧 Environment Setup for Task Management App"
echo "============================================="

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root."
    exit 1
fi

echo ""
echo "🎯 What would you like to set up?"
echo "1. Local Development Environment"
echo "2. Generate JWT Secret"
echo "3. Validate Current Environment"
echo "4. Show Deployment Environment Variables"
echo ""

read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo ""
        print_info "Setting up local development environment..."
        
        # Setup frontend environment
        if [ ! -f ".env" ]; then
            if [ -f ".env.frontend" ]; then
                cp .env.frontend .env
                print_success "Created .env from template"
            else
                print_error ".env.frontend template not found"
                exit 1
            fi
        else
            print_warning ".env already exists"
        fi
        
        # Setup backend environment
        if [ ! -f "server/.env" ]; then
            if [ -f ".env.backend" ]; then
                mkdir -p server
                cp .env.backend server/.env
                print_success "Created server/.env from template"
            else
                print_error ".env.backend template not found"
                exit 1
            fi
        else
            print_warning "server/.env already exists"
        fi
        
        print_info "Please update the environment files with your actual values:"
        echo "📝 Edit .env - Update VITE_API_URL and VITE_WEATHER_API_KEY"
        echo "📝 Edit server/.env - Update MONGODB_URI and JWT_SECRET"
        ;;
        
    2)
        echo ""
        print_info "Generating secure JWT secret..."
        JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(64).toString('hex'))")
        echo ""
        echo "🔐 Your new JWT secret:"
        echo "JWT_SECRET=$JWT_SECRET"
        echo ""
        print_info "Copy this to your environment files (.env.backend or server/.env)"
        ;;
        
    3)
        echo ""
        print_info "Validating current environment setup..."
        
        # Check frontend environment
        if [ -f ".env" ]; then
            print_success "Frontend .env file exists"
            if grep -q "VITE_API_URL" .env; then
                API_URL=$(grep "VITE_API_URL" .env | cut -d '=' -f2)
                echo "  📡 API URL: $API_URL"
            else
                print_warning "VITE_API_URL not found in .env"
            fi
        else
            print_error "Frontend .env file missing"
        fi
        
        # Check backend environment
        if [ -f "server/.env" ]; then
            print_success "Backend server/.env file exists"
            if grep -q "MONGODB_URI" server/.env; then
                print_success "MongoDB URI configured"
            else
                print_warning "MONGODB_URI not found in server/.env"
            fi
            if grep -q "JWT_SECRET" server/.env; then
                print_success "JWT Secret configured"
            else
                print_warning "JWT_SECRET not found in server/.env"
            fi
        else
            print_error "Backend server/.env file missing"
        fi
        ;;
        
    4)
        echo ""
        print_info "Environment variables for deployment platforms:"
        echo ""
        echo "🌐 VERCEL (Frontend):"
        echo "   VITE_API_URL=https://your-backend.onrender.com"
        echo "   VITE_WEATHER_API_KEY=your-weather-api-key"
        echo ""
        echo "🚀 RENDER (Backend):"
        echo "   MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/db"
        echo "   JWT_SECRET=your-64-character-random-string"
        echo "   JWT_EXPIRES_IN=7d"
        echo "   NODE_ENV=production"
        echo "   PORT=10000"
        echo ""
        echo "⚡ RAILWAY (Backend):"
        echo "   Same as Render, but PORT is auto-set"
        echo ""
        echo "🔴 HEROKU (Backend):"
        echo "   Same as Render, set via: heroku config:set KEY=value"
        echo ""
        print_info "See ENVIRONMENT.md for detailed setup instructions"
        ;;
        
    *)
        print_error "Invalid choice. Please run the script again and choose 1-4."
        exit 1
        ;;
esac

echo ""
echo "📚 Additional Resources:"
echo "   📖 ENVIRONMENT.md - Detailed environment setup guide"
echo "   📖 DEPLOYMENT.md - Deployment instructions"
echo "   🌐 MongoDB Atlas: https://www.mongodb.com/atlas"
echo "   🌤️  Weather API: https://www.weatherapi.com/"
echo ""
print_success "Environment setup script completed!"
