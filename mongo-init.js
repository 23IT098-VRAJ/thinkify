// MongoDB initialization script
db = db.getSiblingDB('thinkify');

// Create collections if they don't exist
db.createCollection('users');
db.createCollection('tasks');
db.createCollection('posts');
db.createCollection('products');

// Create indexes for better performance
db.users.createIndex({ "email": 1 }, { unique: true });
db.tasks.createIndex({ "userId": 1 });
db.posts.createIndex({ "userId": 1 });
db.products.createIndex({ "userId": 1 });

print('Database initialized successfully');
