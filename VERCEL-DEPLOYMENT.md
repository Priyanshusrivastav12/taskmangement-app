# Vercel Deployment Guide

## 🚀 Step-by-Step Vercel Deployment

### Step 1: Prepare Your Repository

1. Ensure your code is pushed to GitHub
2. Make sure your `vercel.json` is properly configured (no secret references)

### Step 2: Import Project to Vercel

1. Go to [vercel.com](https://vercel.com) and sign in
2. Click "New Project"
3. Import your GitHub repository `taskmangement-app`
4. Choose the following settings:
   - **Framework Preset**: Vite
   - **Root Directory**: `./` (keep default)
   - **Build Command**: `npm run build` (auto-detected)
   - **Output Directory**: `dist` (auto-detected)

### Step 3: Configure Environment Variables

**IMPORTANT**: Don't use the `vercel.json` file for environment variables. Instead, add them in the Vercel dashboard.

In Vercel Dashboard → Project Settings → Environment Variables, add:

| Name | Value | Environment |
|------|--------|-------------|
| `VITE_API_URL` | `https://your-backend-app.onrender.com` | Production |
| `VITE_API_URL` | `http://localhost:3001` | Development |
| `VITE_WEATHER_API_KEY` | `1540f61f04e444b8a6a192238250112` | All Environments |
| `VITE_APP_NAME` | `Task Management App` | All Environments |
| `VITE_APP_VERSION` | `1.0.0` | All Environments |

### Step 4: Deploy

1. Click "Deploy" 
2. Wait for the build to complete
3. Your app will be available at `https://your-app-name.vercel.app`

## 🔧 Environment Variables Setup

### Method 1: Via Vercel Dashboard (Recommended)

1. Go to your project dashboard
2. Navigate to "Settings" → "Environment Variables"
3. Add each variable:
   - **Name**: `VITE_API_URL`
   - **Value**: Your backend URL (see options below)
   - **Environments**: Select Production, Preview, and/or Development

### Method 2: Via Vercel CLI

```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Set environment variables
vercel env add VITE_API_URL production
vercel env add VITE_WEATHER_API_KEY production
vercel env add VITE_APP_NAME production

# Deploy
vercel --prod
```

## 🌐 Backend URL Options

Choose one based on where you deploy your backend:

### Option 1: Render Backend
```
VITE_API_URL=https://your-backend-app.onrender.com
```

### Option 2: Railway Backend
```
VITE_API_URL=https://your-backend-app.up.railway.app
```

### Option 3: Heroku Backend
```
VITE_API_URL=https://your-backend-app.herokuapp.com
```

### Option 4: Vercel Serverless Functions
```
VITE_API_URL=https://your-app.vercel.app/api
```

## 📱 Complete Environment Variables List

### Required Variables:
```env
VITE_API_URL=https://your-backend-url.com
VITE_WEATHER_API_KEY=1540f61f04e444b8a6a192238250112
```

### Optional Variables:
```env
VITE_APP_NAME=Task Management App
VITE_APP_VERSION=1.0.0
```

## ⚠️ Important Notes

1. **No Secrets in vercel.json**: Don't reference secrets in `vercel.json` that don't exist
2. **VITE_ Prefix**: All frontend environment variables must start with `VITE_`
3. **Public Variables**: Frontend env vars are exposed to the browser
4. **Case Sensitive**: Variable names are case-sensitive
5. **Redeploy**: After adding env vars, redeploy your app

## 🔄 Redeployment

After updating environment variables:

1. Go to your Vercel project dashboard
2. Go to "Deployments" tab
3. Find the latest deployment
4. Click the "..." menu → "Redeploy"

Or trigger a new deployment by pushing to your repository.

## 🐛 Troubleshooting

### Problem: "Secret does not exist" error
**Solution**: Remove secret references from `vercel.json` and use dashboard instead

### Problem: Environment variables not loading
**Solutions**:
- Check variable names have `VITE_` prefix
- Verify variables are set for correct environment (Production/Preview/Development)
- Redeploy the application
- Check build logs for errors

### Problem: CORS errors after deployment
**Solution**: Update your backend CORS configuration to include your Vercel domain:

```javascript
// In your backend server/index.ts
app.use(cors({
  origin: [
    'http://localhost:5173',
    'http://localhost:5174', 
    'https://your-app-name.vercel.app', // Add your Vercel domain
    'https://your-custom-domain.com'    // If you have a custom domain
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
```

## 📋 Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] `vercel.json` configured (no secret references)
- [ ] Environment variables set in Vercel dashboard
- [ ] Backend deployed and accessible
- [ ] Backend CORS updated with Vercel domain
- [ ] Frontend successfully builds locally (`npm run build`)
- [ ] All required dependencies in `package.json`

## 🎉 Success!

Your Task Management App should now be live on Vercel! 

**Next Steps**:
1. Test user registration/login
2. Verify CRUD operations work
3. Check weather widget functionality
4. Set up custom domain (optional)
5. Monitor performance and errors
