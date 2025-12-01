/**
 * Simple MongoDB connection test
 * Run with: npx tsx scripts/test-connection.ts
 */

import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/taskmanagement';

async function testConnection() {
  try {
    console.log('🔄 Testing MongoDB connection...');
    console.log(`📊 URI: ${MONGODB_URI}`);
    
    await mongoose.connect(MONGODB_URI);
    console.log('✅ MongoDB connection successful!');
    
    // Test database operations
    const dbName = mongoose.connection.db?.databaseName;
    console.log(`📁 Connected to database: ${dbName}`);
    
    // List collections
    const collections = await mongoose.connection.db?.listCollections().toArray();
    console.log(`📋 Collections: ${collections?.map(c => c.name).join(', ') || 'None'}`);
    
  } catch (error) {
    console.error('❌ MongoDB connection failed:');
    console.error(error);
  } finally {
    await mongoose.disconnect();
    console.log('🔌 Connection closed');
    process.exit(0);
  }
}

testConnection();
