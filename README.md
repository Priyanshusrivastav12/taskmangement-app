# MERN Stack CRUD Application

A full-stack CRUD application built with React, Express, Node.js, and Supabase (PostgreSQL). This application demonstrates all key concepts of the MERN stack with user authentication, data validation, error handling, external API integration, and state management.

## Features

1. **User Authentication**
   - User registration with validation
   - Login with JWT token authentication
   - Protected routes and API endpoints
   - Secure password hashing with bcrypt

2. **CRUD Operations**
   - Create, Read, Update, Delete items
   - Real-time data synchronization
   - User-specific data isolation with RLS

3. **Data Validation & Error Handling**
   - Server-side validation with express-validator
   - Client-side form validation
   - Comprehensive error handling
   - User-friendly error messages

4. **API Integration**
   - Weather widget with external API
   - Demonstration of third-party API integration
   - Error handling for API failures

5. **State Management**
   - Context API for authentication state
   - Context API for items management
   - Local storage persistence

## Tech Stack

- **Frontend**: React 18, TypeScript, Tailwind CSS, Lucide Icons
- **Backend**: Express.js, Node.js
- **Database**: Supabase (PostgreSQL)
- **Authentication**: JWT, bcryptjs
- **Validation**: express-validator
- **Build Tool**: Vite

## Prerequisites

- Node.js (v18 or higher)
- npm or yarn
- Supabase account (free tier works)

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd <project-directory>
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Configure Environment Variables

The `.env` file is already configured with your Supabase credentials:

```env
VITE_SUPABASE_URL=https://bllacsokngizxwydulzn.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key

JWT_SECRET=mern-app-super-secret-jwt-key-2024
PORT=5000
```

**IMPORTANT**: Change the `JWT_SECRET` before deploying to production!

### 4. Initialize the Database

1. Go to your Supabase Dashboard: https://app.supabase.com
2. Select your project
3. Navigate to the SQL Editor
4. Copy the contents of `scripts/init-db.sql`
5. Paste and run the SQL script

This will create:
- `users` table with authentication fields
- `items` table for CRUD operations
- Row Level Security (RLS) policies for data protection
- Indexes for performance
- Triggers for automatic timestamp updates

### 5. Run the Application

Start both the backend server and frontend development server:

```bash
npm run dev
```

This will start:
- Backend API server on http://localhost:5000
- Frontend development server on http://localhost:5173

### 6. Test the Application

1. Open http://localhost:5173 in your browser
2. Register a new account
3. Log in with your credentials
4. Create, update, and delete items
5. Try the weather widget (note: requires OpenWeatherMap API key)

## Project Structure

```
.
├── server/                 # Backend Express server
│   ├── config/            # Database configuration
│   ├── middleware/        # Authentication & validation middleware
│   ├── routes/            # API routes
│   ├── utils/             # Utility functions (auth helpers)
│   └── index.ts           # Server entry point
├── src/                   # Frontend React application
│   ├── components/        # React components
│   ├── contexts/          # Context API providers
│   ├── App.tsx           # Main app component
│   └── main.tsx          # Application entry point
├── scripts/              # Database initialization scripts
│   └── init-db.sql       # Database schema and RLS policies
└── .env                  # Environment variables
```

## API Endpoints

### Authentication

- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Items (Protected)

- `GET /api/items` - Get all user's items
- `GET /api/items/:id` - Get specific item
- `POST /api/items` - Create new item
- `PUT /api/items/:id` - Update item
- `DELETE /api/items/:id` - Delete item

### Health Check

- `GET /api/health` - Server health status

## Security Features

1. **Password Security**
   - Passwords hashed with bcrypt (salt rounds: 10)
   - Never stored in plain text

2. **JWT Authentication**
   - Tokens expire after 7 days
   - Tokens required for protected routes

3. **Row Level Security (RLS)**
   - Database-level security policies
   - Users can only access their own data
   - Prevents unauthorized data access

4. **Input Validation**
   - Server-side validation on all inputs
   - Email format validation
   - Password length requirements
   - Title and description length limits

5. **Error Handling**
   - No sensitive information in error messages
   - Proper HTTP status codes
   - Centralized error handling

## Deployment

### Frontend (Vercel/Netlify)

1. Build the frontend:
```bash
npm run build
```

2. Deploy the `dist` folder to Vercel or Netlify

3. Set environment variables in your hosting platform

### Backend (Heroku/Railway)

1. Create a new app on Heroku or Railway
2. Set environment variables:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
   - `JWT_SECRET`
   - `PORT`

3. Deploy using Git or CLI

### Database

Your Supabase database is already hosted and configured. No additional deployment needed.

## Testing

The application includes comprehensive error handling and validation. Test the following scenarios:

1. **Authentication**
   - Register with invalid email
   - Register with short password
   - Login with wrong credentials
   - Access protected routes without token

2. **CRUD Operations**
   - Create item with empty title
   - Update item with invalid data
   - Delete non-existent item
   - Try to access another user's items

3. **External API**
   - Test weather widget with valid city
   - Test with invalid city name
   - Handle API rate limits

## Best Practices Implemented

1. **Clean Code**
   - Modular file structure
   - Meaningful variable names
   - Comments for complex logic
   - TypeScript for type safety

2. **Security**
   - Environment variables for secrets
   - Row Level Security in database
   - JWT token authentication
   - Password hashing

3. **Error Handling**
   - Try-catch blocks in async functions
   - User-friendly error messages
   - Proper HTTP status codes
   - Client and server validation

4. **Performance**
   - Database indexes
   - Efficient queries
   - Optimized React re-renders
   - Context API for state management

## Troubleshooting

### Database Connection Issues

If you can't connect to the database:
1. Verify your Supabase credentials in `.env`
2. Check that you've run the `init-db.sql` script
3. Ensure RLS policies are properly configured

### Authentication Not Working

1. Check that `JWT_SECRET` is set in `.env`
2. Clear browser localStorage
3. Verify backend server is running on port 5000

### CORS Errors

1. Ensure backend is running
2. Check that CORS is properly configured in `server/index.ts`
3. Verify frontend is making requests to correct URL

## License

MIT

## Contributing

Pull requests are welcome! Please ensure your code follows the existing style and includes appropriate tests.
# taskmangement-app
