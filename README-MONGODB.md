# MERN Stack Task Management Application

A complete CRUD application built with MongoDB, Express.js, React, and Node.js that fulfills all the requirements of the MERN stack assignment.

## 🎯 Assignment Requirements Completed

### ✅ Basic CRUD Application
- ✅ Create new tasks/items
- ✅ Display all items with real-time updates
- ✅ Update existing items
- ✅ Delete items
- ✅ Complete task management functionality

### ✅ User Authentication
- ✅ User registration with validation
- ✅ User login/logout functionality
- ✅ JWT (JSON Web Token) based authentication
- ✅ Protected routes for authenticated users only
- ✅ Secure password hashing with bcrypt

### ✅ Data Validation and Error Handling
- ✅ Server-side validation using express-validator
- ✅ Client-side form validation
- ✅ Comprehensive error handling for:
  - Invalid inputs
  - Failed database operations
  - Unauthorized access
  - Network errors
- ✅ User-friendly error messages

### ✅ API Integration and State Management
- ✅ Weather API integration (mock implementation)
- ✅ React Context API for state management
- ✅ AuthContext for user authentication state
- ✅ ItemContext for task management state
- ✅ External API data fetching and display

### ✅ RESTful API
- ✅ Complete REST endpoints for users and tasks
- ✅ Proper HTTP methods (GET, POST, PUT, DELETE)
- ✅ Middleware implementation (auth, validation, CORS)
- ✅ Error handling and response formatting
- ✅ MongoDB integration with Mongoose ODM

## 🚀 Technology Stack

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web application framework
- **MongoDB** - NoSQL database
- **Mongoose** - MongoDB object modeling
- **JWT** - Authentication tokens
- **bcryptjs** - Password hashing
- **express-validator** - Input validation
- **CORS** - Cross-origin resource sharing

### Frontend
- **React** - User interface library
- **TypeScript** - Type-safe JavaScript
- **Tailwind CSS** - Utility-first CSS framework
- **Context API** - State management
- **Lucide React** - Icon library

### Development Tools
- **Vite** - Fast build tool
- **tsx** - TypeScript execution
- **concurrently** - Run multiple commands
- **ESLint** - Code linting

## 📁 Project Structure

```
task-management-app/
├── src/                    # Frontend React application
│   ├── components/         # Reusable React components
│   │   ├── AuthForm.tsx
│   │   ├── Dashboard.tsx
│   │   ├── ItemForm.tsx
│   │   ├── ItemList.tsx
│   │   └── WeatherWidget.tsx
│   ├── contexts/           # React Context providers
│   │   ├── AuthContext.tsx
│   │   └── ItemContext.tsx
│   ├── App.tsx
│   └── main.tsx
├── server/                 # Backend Express application
│   ├── config/
│   │   └── database.ts     # MongoDB connection
│   ├── middleware/
│   │   ├── auth.ts         # Authentication middleware
│   │   └── validation.ts   # Input validation
│   ├── models/
│   │   ├── User.ts         # User model
│   │   ├── Item.ts         # Task/Item model
│   │   └── index.ts        # Model exports
│   ├── routes/
│   │   ├── auth.ts         # Authentication routes
│   │   └── items.ts        # CRUD routes for tasks
│   ├── utils/
│   │   └── auth.ts         # Authentication utilities
│   └── index.ts            # Server entry point
├── scripts/
│   ├── init-db.ts          # Database initialization
│   └── test-connection.ts  # Connection testing
├── .env                    # Environment variables
├── package.json            # Dependencies and scripts
└── README.md               # This file
```

## ⚙️ Setup Instructions

### Prerequisites
- Node.js (v18 or higher)
- MongoDB Atlas account OR local MongoDB installation
- Git

### 1. Clone and Install
```bash
git clone <repository-url>
cd task-management-app
npm install
```

### 2. Environment Configuration
Create a `.env` file in the root directory:

```bash
# MongoDB Configuration
MONGODB_URI=mongodb+srv://your-username:your-password@cluster.mongodb.net/taskmanagement

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=7d

# Server Configuration
PORT=5000
NODE_ENV=development
```

**Important**: Replace the MongoDB URI with your actual connection string.

### 3. Database Setup
```bash
# Test MongoDB connection
npm run test-connection

# Initialize database (create indexes)
npm run init-db
```

### 4. Start the Application
```bash
# Start both frontend and backend
npm run dev

# Or start them separately:
npm run server    # Backend only
npm run client    # Frontend only
```

The application will be available at:
- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:5000

## 📡 API Endpoints

### Authentication
```
POST /api/auth/register   # User registration
POST /api/auth/login      # User login
```

### Tasks/Items (Protected Routes)
```
GET    /api/items         # Get all user's items
GET    /api/items/:id     # Get specific item
POST   /api/items         # Create new item
PUT    /api/items/:id     # Update item
DELETE /api/items/:id     # Delete item
```

### Health Check
```
GET    /api/health        # Server health status
```

## 🧪 Testing

### Manual Testing
1. **Registration**: Create a new user account
2. **Login**: Login with created credentials
3. **CRUD Operations**: 
   - Create new tasks
   - View all tasks
   - Edit existing tasks
   - Delete tasks
4. **Weather Widget**: Test external API integration
5. **Authentication**: Test protected routes and logout

### API Testing with cURL
```bash
# Register a new user
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"password123"}'

# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Create a task (replace TOKEN with actual JWT)
curl -X POST http://localhost:5000/api/items \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN" \
  -d '{"title":"Test Task","description":"Test description","status":"pending"}'
```

## 🔒 Security Features

- **Password Hashing**: Secure bcrypt hashing with salt rounds
- **JWT Authentication**: Stateless authentication with expiration
- **Input Validation**: Server and client-side validation
- **CORS Configuration**: Cross-origin request handling
- **Environment Variables**: Secure configuration management
- **Protected Routes**: Authentication required for sensitive operations

## 🌟 Features

### Core Functionality
- User registration and authentication
- Full CRUD operations for tasks
- Real-time UI updates
- Responsive design
- Form validation and error handling

### Additional Features
- Weather widget with external API integration
- Beautiful, modern UI with Tailwind CSS
- Loading states and animations
- Toast notifications for user feedback
- Search and filter functionality
- Task status management (pending, in-progress, completed)

## 🚀 Deployment Ready

The application is configured for easy deployment to platforms like:
- **Vercel** (Frontend)
- **Heroku** (Backend)
- **MongoDB Atlas** (Database)
- **Railway** (Full-stack)
- **AWS** (Full infrastructure)

## 📝 Development Scripts

```bash
npm run dev              # Start development servers
npm run server           # Start backend only
npm run client           # Start frontend only
npm run build            # Build for production
npm run typecheck        # TypeScript type checking
npm run lint             # Code linting
npm run init-db          # Initialize database
npm run test-connection  # Test MongoDB connection
```

## 🎨 UI/UX Features

- **Responsive Design**: Works on all device sizes
- **Modern Interface**: Clean, professional appearance
- **Interactive Elements**: Smooth hover effects and transitions
- **Form Validation**: Real-time validation feedback
- **Loading States**: Clear loading indicators
- **Error Handling**: User-friendly error messages

## 📈 Best Practices Implemented

- **Clean Code**: Meaningful variable names and modular structure
- **Error Handling**: Comprehensive error catching and user feedback
- **Type Safety**: Full TypeScript implementation
- **Security**: Secure authentication and data validation
- **Performance**: Optimized database queries and frontend rendering
- **Maintainability**: Well-organized code structure and documentation

## 🔧 Troubleshooting

### Common Issues
1. **MongoDB Connection**: Ensure your IP is whitelisted in MongoDB Atlas
2. **Environment Variables**: Check `.env` file configuration
3. **Port Conflicts**: Ensure ports 5000 and 5173 are available
4. **CORS Issues**: Check server CORS configuration

### Debug Commands
```bash
# Check server logs
npm run server

# Test database connection
npm run test-connection

# Type checking
npm run typecheck
```

## 📞 Support

For issues or questions, please check:
1. Console logs for detailed error messages
2. Network tab for API call status
3. MongoDB Atlas connection status
4. Environment variable configuration

---

**Built with ❤️ for the MERN Stack Assignment**
