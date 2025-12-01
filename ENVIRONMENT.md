# Environment Variables Setup Guide

This guide explains how to configure environment variables for both local development and production deployment.

## 📁 File Structure

```
task-management-app/
├── .env                    # Frontend environment variables (local)
├── .env.frontend           # Frontend environment template
├── .env.backend            # Backend environment template  
├── server/
│   └── .env               # Backend environment variables (local)
└── DEPLOYMENT.md          # Deployment instructions
```

## 🛠️ Local Development Setup

### Step 1: Frontend Environment Variables

Create `.env` in the project root:

```bash
# Copy from .env.frontend template
cp .env.frontend .env
```

**Required Variables:**
```env
VITE_API_URL=http://localhost:3001
VITE_WEATHER_API_KEY=1540f61f04e444b8a6a192238250112
```

### Step 2: Backend Environment Variables

Create `server/.env`:

```bash
# Create server environment file
cp .env.backend server/.env
```

**Required Variables:**
```env
MONGODB_URI=mongodb+srv://priyanshusrivastav548_db_user:Priyanshu%4012@cluster0.kxnemtr.mongodb.net/taskmanagement
JWT_SECRET=mern-app-super-secret-jwt-key-2024
JWT_EXPIRES_IN=7d
PORT=3001
NODE_ENV=development
```

## 🚀 Production Deployment

### Option 1: Vercel (Frontend) + Render (Backend)

#### Vercel Frontend Environment:
```env
VITE_API_URL=https://your-app-name.onrender.com
VITE_WEATHER_API_KEY=your-weather-api-key
```

#### Render Backend Environment:
```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/taskmanagement
JWT_SECRET=64-character-random-string
JWT_EXPIRES_IN=7d
NODE_ENV=production
PORT=10000
```

### Option 2: Full Vercel Deployment

#### Vercel Environment (Frontend + Serverless API):
```env
VITE_API_URL=https://your-app.vercel.app/api
VITE_WEATHER_API_KEY=your-weather-api-key
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/taskmanagement
JWT_SECRET=64-character-random-string
JWT_EXPIRES_IN=7d
NODE_ENV=production
```

## 🔐 Security Best Practices

### JWT Secret Generation

Generate a secure JWT secret:

```bash
# Node.js method
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"

# OpenSSL method
openssl rand -hex 64

# Online generator (use with caution)
# https://www.allkeysgenerator.com/Random/Security-Encryption-Key-Generator.aspx
```

### MongoDB Atlas Setup

1. **Create Account**: Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. **Create Cluster**: Choose free tier
3. **Database Access**: Create user with read/write permissions
4. **Network Access**: Add IP addresses (0.0.0.0/0 for development)
5. **Connection String**: Get URI and replace username/password

**Connection String Format:**
```
mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<database>
```

**Special Characters in Password:**
- `@` becomes `%40`
- `#` becomes `%23`
- `$` becomes `%24`
- `%` becomes `%25`

## 📋 Platform-Specific Instructions

### Vercel

1. Go to Vercel Dashboard
2. Select your project
3. Go to Settings → Environment Variables
4. Add variables one by one

**Required for Frontend:**
- `VITE_API_URL`
- `VITE_WEATHER_API_KEY`

### Render

1. Go to Render Dashboard
2. Select your web service
3. Go to Environment tab
4. Add variables

**Required for Backend:**
- `MONGODB_URI`
- `JWT_SECRET`
- `JWT_EXPIRES_IN`
- `NODE_ENV`

### Railway

1. Go to Railway Dashboard
2. Select your project
3. Go to Variables tab
4. Add variables

**Auto-set by Railway:**
- `PORT` (automatically provided)

### Heroku

Using Heroku CLI:
```bash
heroku config:set MONGODB_URI="your-mongodb-uri"
heroku config:set JWT_SECRET="your-jwt-secret"
heroku config:set NODE_ENV="production"
```

## 🧪 Testing Environment Variables

### Frontend Testing:
```javascript
// In your React component
console.log('API URL:', import.meta.env.VITE_API_URL);
console.log('Weather API Key:', import.meta.env.VITE_WEATHER_API_KEY);
```

### Backend Testing:
```javascript
// In your server code
console.log('MongoDB URI:', process.env.MONGODB_URI ? 'Set' : 'Not set');
console.log('JWT Secret:', process.env.JWT_SECRET ? 'Set' : 'Not set');
console.log('Port:', process.env.PORT);
console.log('Environment:', process.env.NODE_ENV);
```

## ⚠️ Common Issues

### 1. CORS Errors
**Problem:** Frontend can't connect to backend
**Solution:** Update CORS configuration with production URLs

```javascript
// server/index.ts
app.use(cors({
  origin: [
    'http://localhost:5173',
    'http://localhost:5174',
    'https://your-frontend-domain.vercel.app'
  ],
  credentials: true
}));
```

### 2. MongoDB Connection Issues
**Problem:** Database connection failed
**Solutions:**
- Check MongoDB Atlas network access
- Verify connection string format
- Ensure database user has proper permissions
- Check for special characters in password

### 3. Environment Variables Not Loading
**Problem:** Variables showing as undefined
**Solutions:**
- Restart development servers
- Check variable names (VITE_ prefix for frontend)
- Verify file locations (.env in root, server/.env for backend)
- Check deployment platform environment settings

## 📚 Environment Files Summary

| File | Purpose | Location | Variables |
|------|---------|----------|-----------|
| `.env` | Frontend local development | Project root | `VITE_*` variables |
| `server/.env` | Backend local development | server/ folder | Server variables |
| `.env.frontend` | Frontend template | Project root | Template with examples |
| `.env.backend` | Backend template | Project root | Template with examples |

## 🚨 Security Reminders

- ✅ Never commit `.env` files to version control
- ✅ Use different databases for development/production
- ✅ Rotate JWT secrets regularly
- ✅ Use strong, unique passwords
- ✅ Restrict MongoDB Atlas network access
- ✅ Enable MongoDB Atlas security features
- ❌ Don't share environment variables in public channels
- ❌ Don't use weak or default JWT secrets
- ❌ Don't store sensitive data in frontend variables
