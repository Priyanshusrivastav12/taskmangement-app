# Task Management App - MongoDB Setup Guide

This guide explains how to set up and use MongoDB with your Task Management App.

## Prerequisites

1. **MongoDB Installation**: You need MongoDB installed on your machine or use MongoDB Atlas (cloud).
   
   **Local Installation:**
   - macOS: `brew install mongodb/brew/mongodb-community`
   - Ubuntu: Follow [MongoDB installation guide](https://docs.mongodb.com/manual/installation/)
   - Windows: Download from [MongoDB website](https://www.mongodb.com/try/download/community)

   **Cloud Option (MongoDB Atlas):**
   - Sign up at [MongoDB Atlas](https://cloud.mongodb.com)
   - Create a cluster and get connection string

## Environment Setup

1. **Update `.env` file** with your MongoDB URI:
   ```
   MONGODB_URI=mongodb://localhost:27017/taskmanagement
   # OR for MongoDB Atlas:
   # MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/taskmanagement
   
   JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
   JWT_EXPIRES_IN=7d
   PORT=5000
   NODE_ENV=development
   ```

2. **For MongoDB Atlas users**:
   - Replace `username` and `password` with your database user credentials
   - Replace `cluster` with your cluster name
   - Make sure to whitelist your IP address in MongoDB Atlas

## Database Initialization

1. **Start MongoDB** (if using local installation):
   ```bash
   # macOS/Linux
   brew services start mongodb-community
   # OR
   mongod
   
   # Windows
   net start MongoDB
   ```

2. **Initialize the database**:
   ```bash
   npm run init-db
   ```
   
   This will:
   - Connect to MongoDB
   - Create the necessary collections
   - Set up indexes for performance
   - Create sample data (optional)

## Running the Application

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Start the development server**:
   ```bash
   npm run dev
   ```
   
   This starts both the backend server (port 5000) and frontend (port 5173)

3. **Test the setup**:
   - Backend health check: http://localhost:5000/api/health
   - Frontend: http://localhost:5173

## MongoDB Collections

### Users Collection
- **_id**: ObjectId (auto-generated)
- **email**: String (unique, required)
- **password_hash**: String (hashed password)
- **name**: String (required)
- **created_at**: Date (auto-generated)
- **updated_at**: Date (auto-updated)

### Items Collection
- **_id**: ObjectId (auto-generated)
- **user_id**: ObjectId (references User)
- **title**: String (required)
- **description**: String (optional)
- **status**: String (enum: 'pending', 'completed', 'in-progress')
- **created_at**: Date (auto-generated)
- **updated_at**: Date (auto-updated)

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Items (Protected routes)
- `GET /api/items` - Get all user items
- `GET /api/items/:id` - Get specific item
- `POST /api/items` - Create new item
- `PUT /api/items/:id` - Update item
- `DELETE /api/items/:id` - Delete item

## Sample Data

After running `npm run init-db`, you can log in with:
- **Email**: admin@example.com
- **Password**: admin123

## Troubleshooting

### Common Issues:

1. **Connection Error**: 
   - Check if MongoDB is running
   - Verify MONGODB_URI in .env file
   - For Atlas: Check network access and credentials

2. **Authentication Error**:
   - Check JWT_SECRET in .env file
   - Ensure token is being sent in Authorization header

3. **Permission Error**:
   - MongoDB user needs read/write permissions
   - Check database user credentials

### Useful Commands:

```bash
# Check MongoDB status (macOS/Linux)
brew services list | grep mongodb

# Connect to MongoDB shell
mongosh

# View all databases
show dbs

# Use your database
use taskmanagement

# View collections
show collections

# View users
db.users.find()

# View items
db.items.find()
```

## Production Deployment

1. **Set environment variables**:
   ```
   NODE_ENV=production
   MONGODB_URI=your-production-mongodb-uri
   JWT_SECRET=very-secure-secret-key
   PORT=5000
   ```

2. **Security considerations**:
   - Use strong JWT secrets
   - Enable MongoDB authentication
   - Use SSL/TLS connections
   - Set up proper firewall rules
   - Consider using MongoDB Atlas for managed hosting

## Migration from Supabase

If you're migrating from the previous Supabase version:

1. Export your existing data from Supabase
2. Transform the data format (UUID to ObjectId, adjust field names)
3. Import into MongoDB using the init script or custom migration
4. Update environment variables
5. Test all functionality

The new MongoDB version provides better performance and more flexibility for complex queries and relationships.
