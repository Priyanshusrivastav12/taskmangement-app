# 🚀 Render Backend Deployment Guide

## Prerequisites

✅ GitHub repository with your code
✅ MongoDB Atlas database setup
✅ Render account (free at render.com)

---

## Step 1: Fix Your Current Render Configuration

Based on your screenshot, here are the correct settings for your Render web service:

### Basic Settings:
- **Name**: `task-management-backend`
- **Language**: Node
- **Branch**: `main`
- **Region**: Oregon (US West) ✅

### Build & Deploy Settings:
- **Root Directory**: `server`
- **Build Command**: `npm install && npm run build`
- **Start Command**: `npm start`

---

## Step 2: Environment Variables Setup

In your Render dashboard, add these environment variables:

| Variable Name | Value | Notes |
|---------------|-------|--------|
| `MONGODB_URI` | `mongodb+srv://priyanshusrivastav548_db_user:Priyanshu%4012@cluster0.kxnemtr.mongodb.net/taskmanagement` | Your MongoDB Atlas connection string |
| `JWT_SECRET` | `[Generate new secure secret]` | Use the generator below |
| `JWT_EXPIRES_IN` | `7d` | Token expiration time |
| `NODE_ENV` | `production` | Environment setting |
| `PORT` | `10000` | Render's default port |

### Generate Secure JWT Secret:
```bash
# Run this command to generate a secure JWT secret:
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

---

## Step 3: Current Issues to Fix

Looking at your screenshot, I see these issues:

### ❌ Issue 1: Start Command Error
**Problem**: The start command `yarn start` is failing
**Solution**: Update to use npm instead:
```
npm start
```

### ❌ Issue 2: Root Directory
**Problem**: Commands might be running from wrong directory
**Solution**: Set Root Directory to `server`

### ❌ Issue 3: Build Command
**Problem**: Need proper build command
**Solution**: Use:
```
npm install && npm run build
```

---

## Step 4: Manual Setup (Recommended)

Since you already have the service created, let's fix it manually:

### 1. Update Service Settings:
- Go to your service dashboard
- Click "Settings" tab
- Update the following:

**Environment:**
- Language: `Node`
- Branch: `main`
- Root Directory: `server`

**Build & Deploy:**
- Build Command: `npm install && npm run build`
- Start Command: `npm start`

### 2. Add Environment Variables:
- Go to "Environment" tab
- Add each variable from the table above

### 3. Manual Deploy:
- Go to "Deploys" tab
- Click "Deploy latest commit"

---

## Step 5: Verify Deployment

Once deployed, test these endpoints:

### Health Check:
```
GET https://your-app-name.onrender.com/api/health
```
Expected response: `{"status": "Server is running", "timestamp": "..."}`

### Test Auth Endpoint:
```bash
curl -X POST https://your-app-name.onrender.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123","name":"Test User"}'
```

---

## Step 6: Update Frontend Configuration

Once your backend is deployed, update your frontend:

### 1. Update Environment Variables:
In Vercel or your frontend hosting platform:
```env
VITE_API_URL=https://your-render-app-name.onrender.com
```

### 2. Update CORS Settings:
In `server/index.ts`, ensure your frontend domain is allowed:

```javascript
app.use(cors({
  origin: [
    'http://localhost:5173',
    'http://localhost:5174',
    'https://your-frontend-domain.vercel.app' // Add your frontend URL
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
```

---

## 🔧 Quick Fix Commands

If you want to redeploy quickly, run these commands in your terminal:

```bash
# 1. Ensure you're in the project root
cd "/Users/priyanshusrivastav/Downloads/task management app"

# 2. Test build locally
cd server && npm install && npm run build

# 3. Push changes to GitHub
git add .
git commit -m "Fix Render deployment configuration"
git push origin main
```

Then trigger a manual deploy in Render.

---

## 📊 Deployment Checklist

- [ ] Root directory set to `server`
- [ ] Build command: `npm install && npm run build`
- [ ] Start command: `npm start`
- [ ] All environment variables added
- [ ] MongoDB Atlas accessible
- [ ] Health endpoint working
- [ ] CORS configured for frontend domain

---

## 🐛 Troubleshooting

### Build Fails:
- Check `package.json` in server directory exists
- Verify all dependencies are listed
- Check TypeScript configuration

### Start Command Fails:
- Ensure `dist/index.js` exists after build
- Check for TypeScript compilation errors
- Verify start script in package.json

### Database Connection Issues:
- Verify MongoDB Atlas URI format
- Check network access settings in MongoDB Atlas
- Test connection string locally

### Environment Variables Not Loading:
- Refresh environment variables in Render
- Check variable names (case-sensitive)
- Redeploy after adding variables

---

## 📱 Your Render App URL

Once deployed successfully, your backend will be available at:
```
https://task-management-backend.onrender.com
```

Use this URL as your `VITE_API_URL` in your frontend configuration.

---

## 🎉 Next Steps

1. ✅ Deploy backend on Render
2. ✅ Update frontend with backend URL
3. ✅ Deploy frontend on Vercel
4. ✅ Test complete application
5. ✅ Set up custom domain (optional)

Your Task Management App will be fully deployed and accessible to users worldwide! 🌍
