#!/bin/bash

# Vercel Environment Variables Setup Helper
# This script helps you set environment variables for Vercel deployment

echo "🚀 Vercel Environment Variables Setup"
echo "===================================="

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

echo ""
echo "🔐 Setting up environment variables for Vercel..."
echo ""

# Get backend URL from user
read -p "Enter your backend URL (e.g., https://your-app.onrender.com): " BACKEND_URL

if [ -z "$BACKEND_URL" ]; then
    echo "❌ Backend URL is required!"
    exit 1
fi

echo ""
echo "🌤️ Using default Weather API key (you can change this later in Vercel dashboard)"
WEATHER_API_KEY="1540f61f04e444b8a6a192238250112"

echo ""
echo "📋 Summary of environment variables to set:"
echo "VITE_API_URL=$BACKEND_URL"
echo "VITE_WEATHER_API_KEY=$WEATHER_API_KEY"
echo "VITE_APP_NAME=Task Management App"
echo "VITE_APP_VERSION=1.0.0"

echo ""
read -p "Do you want to set these via Vercel CLI? (y/n): " SET_VIA_CLI

if [ "$SET_VIA_CLI" = "y" ] || [ "$SET_VIA_CLI" = "Y" ]; then
    echo ""
    echo "🔑 Login to Vercel first..."
    vercel login
    
    echo ""
    echo "🏗️ Setting environment variables..."
    
    echo "$BACKEND_URL" | vercel env add VITE_API_URL production
    echo "$WEATHER_API_KEY" | vercel env add VITE_WEATHER_API_KEY production  
    echo "Task Management App" | vercel env add VITE_APP_NAME production
    echo "1.0.0" | vercel env add VITE_APP_VERSION production
    
    echo ""
    echo "✅ Environment variables set!"
    echo ""
    echo "🚀 Now deploy with: vercel --prod"
else
    echo ""
    echo "📋 Manual setup instructions:"
    echo "1. Go to vercel.com"
    echo "2. Select your project"
    echo "3. Go to Settings → Environment Variables"
    echo "4. Add the following variables:"
    echo ""
    echo "   VITE_API_URL = $BACKEND_URL"
    echo "   VITE_WEATHER_API_KEY = $WEATHER_API_KEY"
    echo "   VITE_APP_NAME = Task Management App"
    echo "   VITE_APP_VERSION = 1.0.0"
    echo ""
    echo "5. Set environment to 'Production' for each"
    echo "6. Click 'Save' for each variable"
    echo "7. Redeploy your application"
fi

echo ""
echo "📚 Additional resources:"
echo "   📖 VERCEL-DEPLOYMENT.md - Complete deployment guide"
echo "   🌐 Vercel Dashboard: https://vercel.com/dashboard"
echo ""
echo "✨ Your Task Management App is ready for deployment!"
