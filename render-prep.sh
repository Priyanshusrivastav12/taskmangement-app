#!/bin/bash

# Render Deployment Preparation Script
# This script helps prepare your backend for Render deployment

echo "🚀 Render Backend Deployment Preparation"
echo "======================================="

# Colors
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

print_info "Checking project structure for Render deployment..."

# Check server directory
if [ -d "server" ]; then
    print_success "Server directory found"
else
    print_error "Server directory not found"
    exit 1
fi

# Check server package.json
if [ -f "server/package.json" ]; then
    print_success "Server package.json found"
else
    print_error "server/package.json not found"
    exit 1
fi

# Check server TypeScript config
if [ -f "server/tsconfig.json" ]; then
    print_success "Server TypeScript config found"
else
    print_warning "server/tsconfig.json not found - creating one..."
    
    # Create TypeScript config for server
    cat > server/tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": ".",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": false,
    "removeComments": true
  },
  "include": ["**/*.ts"],
  "exclude": ["node_modules", "dist"]
}
EOF
    print_success "Created server/tsconfig.json"
fi

# Test server build
print_info "Testing server build..."
cd server

# Install dependencies
print_info "Installing server dependencies..."
npm install

if [ $? -eq 0 ]; then
    print_success "Server dependencies installed"
else
    print_error "Failed to install server dependencies"
    exit 1
fi

# Build server
print_info "Building server..."
npm run build

if [ $? -eq 0 ]; then
    print_success "Server build successful"
else
    print_error "Server build failed"
    exit 1
fi

# Check if dist/index.js was created
if [ -f "dist/index.js" ]; then
    print_success "Build output (dist/index.js) created successfully"
else
    print_error "Build output not found - check TypeScript configuration"
    exit 1
fi

cd ..

# Generate JWT Secret
print_info "Generating secure JWT secret..."
JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(64).toString('hex'))")

echo ""
echo "🔐 Your JWT Secret (copy this for Render environment variables):"
echo "JWT_SECRET=$JWT_SECRET"
echo ""

# Check environment template
if [ -f ".env.backend" ]; then
    print_success "Backend environment template found"
else
    print_warning "Backend environment template not found"
fi

# Check if changes need to be committed
if git status &>/dev/null; then
    if [ -n "$(git status --porcelain)" ]; then
        print_warning "You have uncommitted changes. Consider committing them before deployment."
        echo ""
        read -p "Do you want to commit changes now? (y/n): " COMMIT_CHANGES
        
        if [ "$COMMIT_CHANGES" = "y" ] || [ "$COMMIT_CHANGES" = "Y" ]; then
            git add .
            git commit -m "Prepare for Render deployment: Add server build configuration"
            git push origin main
            print_success "Changes committed and pushed to GitHub"
        fi
    else
        print_success "Working directory is clean"
    fi
else
    print_warning "Not a Git repository. You'll need to push code to GitHub for Render deployment."
fi

echo ""
echo "🎯 Render Deployment Configuration:"
echo "=================================="
echo "Root Directory: server"
echo "Build Command: npm install && npm run build"
echo "Start Command: npm start"
echo "Health Check Path: /api/health"
echo ""

echo "🔑 Environment Variables for Render:"
echo "===================================="
echo "MONGODB_URI=mongodb+srv://priyanshusrivastav548_db_user:Priyanshu%4012@cluster0.kxnemtr.mongodb.net/taskmanagement"
echo "JWT_SECRET=$JWT_SECRET"
echo "JWT_EXPIRES_IN=7d"
echo "NODE_ENV=production"
echo "PORT=10000"
echo ""

echo "📋 Next Steps:"
echo "============="
echo "1. Go to render.com and create a new Web Service"
echo "2. Connect your GitHub repository"
echo "3. Use the configuration shown above"
echo "4. Add the environment variables listed above"
echo "5. Deploy your service"
echo ""

echo "📖 For detailed instructions, see RENDER-DEPLOYMENT.md"
echo ""
print_success "Render deployment preparation completed!"

# Test health endpoint locally
print_info "Testing if server can start locally..."
echo "You can test the server locally with: cd server && npm start"
echo "Then visit: http://localhost:3001/api/health"
