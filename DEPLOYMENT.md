# Deployment Guide

This guide covers deploying your MERN stack Task Management App to production using different hosting platforms.

## 🚀 Quick Deploy Options

### Option 1: Vercel (Frontend) + Render (Backend) - Recommended
- **Frontend**: Vercel (Free tier available)
- **Backend**: Render (Free tier available)
- **Database**: MongoDB Atlas (Free tier available)

### Option 2: Full Vercel Deployment
- **Frontend**: Vercel Static Site
- **Backend**: Vercel Serverless Functions
- **Database**: MongoDB Atlas

---

## 📋 Pre-Deployment Checklist

- [ ] MongoDB Atlas database setup and accessible
- [ ] Environment variables documented
- [ ] Code pushed to GitHub repository
- [ ] Frontend builds successfully (`npm run build`)
- [ ] Backend starts without errors (`npm run server`)

---

## 🌐 Option 1: Vercel + Render Deployment

### Step 1: Deploy Backend to Render

#### 1.1 Prepare Backend for Render

Create `render.yaml` in your project root:

```yaml
services:
  - type: web
    name: task-management-backend
    env: node
    plan: free
    buildCommand: cd server && npm install
    startCommand: cd server && npm start
    envVars:
      - key: NODE_ENV
        value: production
      - key: MONGODB_URI
        fromDatabase:
          name: mongodb
          property: connectionString
      - key: JWT_SECRET
        generateValue: true
      - key: JWT_EXPIRES_IN
        value: 7d
      - key: PORT
        value: 10000
```

#### 1.2 Update Server Package.json

Add production start script to `server/package.json`:

```json
{
  "scripts": {
    "start": "node dist/index.js",
    "build": "tsc",
    "dev": "tsx watch index.ts",
    "postinstall": "npm run build"
  }
}
```

#### 1.3 Deploy to Render

1. Go to [render.com](https://render.com)
2. Connect your GitHub account
3. Click "New +" → "Web Service"
4. Select your repository
5. Configure:
   - **Name**: `task-management-backend`
   - **Root Directory**: `server`
   - **Environment**: `Node`
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm start`
6. Add environment variables:
   - `MONGODB_URI`: Your MongoDB Atlas connection string
   - `JWT_SECRET`: Generate a secure random string
   - `JWT_EXPIRES_IN`: `7d`
   - `NODE_ENV`: `production`

### Step 2: Deploy Frontend to Vercel

#### 2.1 Update Frontend Environment

Create `vercel.json` in project root:

```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

#### 2.2 Deploy to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Import your GitHub repository
3. Configure build settings:
   - **Framework Preset**: Vite
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
4. Add environment variables:
   - `VITE_API_URL`: Your Render backend URL (e.g., `https://task-management-backend.onrender.com`)

### Step 3: Update CORS Configuration

Update `server/index.ts` to include your production domains:

```typescript
app.use(cors({
  origin: [
    'http://localhost:5173', 
    'http://localhost:5174', 
    'http://localhost:3000',
    'https://your-vercel-app.vercel.app', // Replace with your Vercel URL
    'https://your-custom-domain.com' // If you have a custom domain
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
```

---

## 🔧 Option 2: Full Vercel Deployment

### Step 1: Convert Backend to Serverless Functions

#### 1.1 Create API Directory Structure

```
api/
  auth/
    login.ts
    register.ts
  items/
    index.ts
    [id].ts
  health.ts
```

#### 1.2 Create Serverless Function for Auth

Create `api/auth/register.ts`:

```typescript
import { VercelRequest, VercelResponse } from '@vercel/node';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { connectDatabase } from '../../server/config/database';
import User from '../../server/models/User';

export default async function handler(req: VercelRequest, res: VercelResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    await connectDatabase();

    const { email, password, name } = req.body;

    // Validation
    if (!email || !password || !name) {
      return res.status(400).json({ error: 'All fields are required' });
    }

    // Check if user exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ error: 'User already exists' });
    }

    // Hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create user
    const user = new User({
      email,
      password: hashedPassword,
      name
    });

    await user.save();

    // Generate JWT
    const token = jwt.sign(
      { userId: user._id },
      process.env.JWT_SECRET!,
      { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
    );

    res.status(201).json({
      token,
      user: {
        id: user._id,
        email: user.email,
        name: user.name
      }
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

#### 1.3 Update Vercel Configuration

Update `vercel.json`:

```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    },
    {
      "src": "api/**/*.ts",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/$1"
    },
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ],
  "env": {
    "MONGODB_URI": "@mongodb-uri",
    "JWT_SECRET": "@jwt-secret",
    "JWT_EXPIRES_IN": "7d"
  }
}
```

### Step 2: Deploy to Vercel

1. Push all changes to GitHub
2. Import project to Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

---

## 🔐 Environment Variables Setup

### For Render Backend:
- `MONGODB_URI`: MongoDB Atlas connection string
- `JWT_SECRET`: Secure random string (use crypto.randomBytes(64).toString('hex'))
- `JWT_EXPIRES_IN`: `7d`
- `NODE_ENV`: `production`
- `PORT`: `10000` (Render default)

### For Vercel Frontend:
- `VITE_API_URL`: Backend URL (Render URL or Vercel API URL)

### For Full Vercel Deployment:
- `MONGODB_URI`: MongoDB Atlas connection string
- `JWT_SECRET`: Secure random string
- `JWT_EXPIRES_IN`: `7d`

---

## 🛠️ Build Scripts

### Frontend Build Script

Update `package.json`:

```json
{
  "scripts": {
    "build": "tsc && vite build",
    "preview": "vite preview",
    "postbuild": "echo 'Build completed successfully'"
  }
}
```

### Backend Build Script (for Render)

Update `server/package.json`:

```json
{
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "postinstall": "npm run build"
  }
}
```

---

## 🌍 Domain and SSL

### Vercel:
- Automatic SSL certificates
- Custom domain support
- Edge network optimization

### Render:
- Automatic SSL certificates
- Custom domain support (paid plans)

---

## 📊 Monitoring and Logs

### Vercel:
- Real-time function logs
- Performance analytics
- Error tracking

### Render:
- Application logs
- Performance metrics
- Health checks

---

## 🚨 Troubleshooting

### Common Issues:

1. **CORS Errors**: Update CORS configuration with production URLs
2. **Environment Variables**: Ensure all required env vars are set
3. **Build Failures**: Check build logs and dependencies
4. **Database Connection**: Verify MongoDB Atlas network access

### Debug Steps:

1. Check deployment logs
2. Verify environment variables
3. Test API endpoints individually
4. Monitor database connections

---

## 📚 Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Render Documentation](https://render.com/docs)
- [MongoDB Atlas Setup](https://www.mongodb.com/atlas)
- [GitHub Repository Setup](https://docs.github.com/en/repositories)

---

## 🎉 Post-Deployment

After successful deployment:

1. ✅ Test user registration/login
2. ✅ Verify CRUD operations
3. ✅ Check weather widget functionality
4. ✅ Test responsive design
5. ✅ Monitor application performance

Your Task Management App is now live! 🚀
