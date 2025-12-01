/**
 * MongoDB Database Initialization
 * 
 * This file contains MongoDB setup and initialization code for the Task Management App
 * Run this with: npm run init-db
 */

import mongoose from 'mongoose';
import dotenv from 'dotenv';
import { User, Item } from '../server/models';

// Load environment variables
dotenv.config();

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/taskmanagement';

/**
 * Initialize MongoDB database with collections and indexes
 */
async function initializeDatabase() {
  try {
    // Connect to MongoDB
    console.log('Connecting to MongoDB...');
    await mongoose.connect(MONGODB_URI);
    console.log('✅ Connected to MongoDB successfully');

    // Create collections with indexes (without dropping existing data)
    console.log('Creating collections and indexes...');
    
    // Users collection will be created automatically when first document is inserted
    // But we can ensure indexes are created
    await User.createIndexes();
    console.log('✅ User collection indexes created');

    // Items collection will be created automatically when first document is inserted
    await Item.createIndexes();
    console.log('✅ Item collection indexes created');

    console.log('\n🎉 Database initialization completed successfully!');
    console.log(`📊 Database: ${MONGODB_URI}`);
    console.log('� Ready to accept user registrations and data');

  } catch (error) {
    console.error('❌ Database initialization failed:', error);
    process.exit(1);
  } finally {
    await mongoose.disconnect();
    console.log('🔌 Database connection closed');
  }
}

// Run initialization
initializeDatabase();

export default initializeDatabase;
