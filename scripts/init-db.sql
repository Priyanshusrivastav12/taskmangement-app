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

    // Drop existing collections if they exist (for clean initialization)
    console.log('Dropping existing collections...');
    await mongoose.connection.db.dropDatabase();
    console.log('✅ Database cleared');

    // Create collections with indexes
    console.log('Creating collections and indexes...');
    
    // Users collection will be created automatically when first document is inserted
    // But we can ensure indexes are created
    await User.createIndexes();
    console.log('✅ User collection indexes created');

    // Items collection will be created automatically when first document is inserted
    await Item.createIndexes();
    console.log('✅ Item collection indexes created');

    // Create a sample user (optional - for testing)
    console.log('Creating sample data...');
    const sampleUser = new User({
      email: 'admin@example.com',
      password_hash: 'admin123', // This will be hashed automatically
      name: 'Admin User'
    });
    await sampleUser.save();
    console.log('✅ Sample user created');

    // Create sample items
    const sampleItem = new Item({
      user_id: sampleUser._id,
      title: 'Welcome Task',
      description: 'This is your first task. Complete it to get started!',
      status: 'pending'
    });
    await sampleItem.save();
    console.log('✅ Sample item created');

    console.log('\n🎉 Database initialization completed successfully!');
    console.log(`📊 Database: ${MONGODB_URI}`);
    console.log('📝 Sample login credentials:');
    console.log('   Email: admin@example.com');
    console.log('   Password: admin123');

  } catch (error) {
    console.error('❌ Database initialization failed:', error);
    process.exit(1);
  } finally {
    await mongoose.disconnect();
    console.log('🔌 Database connection closed');
  }
}

// Run initialization if this file is executed directly
if (require.main === module) {
  initializeDatabase();
}

export default initializeDatabase;
