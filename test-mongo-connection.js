const mongoose = require('mongoose');
require('dotenv').config({ path: 'server/.env' });

async function testMongoConnection() {
  console.log('🔍 Testing MongoDB Atlas connection...');
  console.log('📊 Connection string:', process.env.MONGODB_URI ? 'Set' : 'Not set');
  
  try {
    console.log('⏳ Connecting to MongoDB Atlas...');
    await mongoose.connect(process.env.MONGODB_URI, {
      serverSelectionTimeoutMS: 10000, // 10 second timeout
    });
    
    console.log('✅ MongoDB Atlas connection successful!');
    console.log('📋 Database name:', mongoose.connection.db.databaseName);
    console.log('🌍 Connected to cluster:', mongoose.connection.host);
    
    // Test a simple operation
    const collections = await mongoose.connection.db.listCollections().toArray();
    console.log(`📁 Available collections: ${collections.length > 0 ? collections.map(c => c.name).join(', ') : 'None yet'}`);
    
    await mongoose.disconnect();
    console.log('✅ Test completed successfully!');
    
  } catch (error) {
    console.error('❌ MongoDB connection failed:');
    console.error('Error:', error.message);
    
    if (error.message.includes('IP')) {
      console.log('\n🔧 Fix: Add 0.0.0.0/0 to MongoDB Atlas Network Access');
      console.log('1. Go to https://cloud.mongodb.com');
      console.log('2. Navigate to Network Access');
      console.log('3. Add IP Address: 0.0.0.0/0');
    }
    
    if (error.message.includes('authentication')) {
      console.log('\n🔧 Fix: Check MongoDB Atlas credentials');
      console.log('1. Verify username and password');
      console.log('2. Check Database Access permissions');
    }
  }
}

testMongoConnection();
