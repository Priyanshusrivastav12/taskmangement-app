#!/bin/bash

# Build Test Script - Test if the backend builds successfully
echo "🔧 Testing Backend Build for Render Deployment"
echo "=============================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

cd server

echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Dependencies installed successfully${NC}"
else
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi

echo ""
echo "🏗️  Building TypeScript..."
npm run build

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Build successful!${NC}"
    echo ""
    echo "📁 Build output:"
    ls -la dist/
    echo ""
    echo -e "${GREEN}🎉 Your backend is ready for Render deployment!${NC}"
    echo ""
    echo "📋 Next steps:"
    echo "1. Commit and push these changes to GitHub"
    echo "2. In Render dashboard, trigger a manual deploy"
    echo "3. Monitor the deployment logs"
else
    echo -e "${RED}❌ Build failed!${NC}"
    echo ""
    echo "🔍 Please check the TypeScript errors above and fix them."
    exit 1
fi
