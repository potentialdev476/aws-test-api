#!/bin/bash

# Laravel Backend Deployment Script
echo "🚀 Deploying Laravel Backend..."

# Install dependencies
echo "📦 Installing dependencies..."
composer install --no-dev --optimize-autoloader

# Set up environment
echo "⚙️ Setting up environment..."
cp .env.example .env
php artisan key:generate

# Cache configuration
echo "💾 Caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set permissions
echo "🔐 Setting permissions..."
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

echo "✅ Laravel Backend deployment completed!"
echo "🌐 Access at: http://your-ec2-ip/api/"
