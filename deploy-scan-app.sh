#!/bin/bash

# Book Scanner App - Deployment Script
# This script helps deploy the scan app to Vercel with AWS SES configuration

set -e

echo "📚 Book Scanner App - Deployment Script"
echo "========================================"
echo ""

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI not found. Installing..."
    npm i -g vercel
    echo "✅ Vercel CLI installed"
else
    echo "✅ Vercel CLI found"
fi

# Navigate to frontend directory
cd frontend

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install
echo "✅ Dependencies installed"

# Check if already linked
if [ ! -f ".vercel/project.json" ]; then
    echo ""
    echo "🔗 Linking Vercel project..."
    vercel link
else
    echo "✅ Project already linked"
fi

echo ""
echo "🔐 Environment Variables Setup"
echo "=============================="
echo ""
echo "You need to set the following environment variables:"
echo ""
echo "  1. AWS_ACCESS_KEY_ID"
echo "  2. AWS_SECRET_ACCESS_KEY"
echo "  3. AWS_REGION (default: us-east-1)"
echo "  4. AWS_SES_FROM_EMAIL (default: Mikevicentecs@gmail.com)"
echo "  5. SCAN_LOG_EMAIL (default: Mikevicentecs@gmail.com)"
echo ""
echo "Run these commands manually (they require interactive input):"
echo ""
echo "  vercel env add AWS_ACCESS_KEY_ID"
echo "  vercel env add AWS_SECRET_ACCESS_KEY"
echo "  vercel env add AWS_REGION"
echo "  vercel env add AWS_SES_FROM_EMAIL"
echo "  vercel env add SCAN_LOG_EMAIL"
echo ""
read -p "Press Enter when you've set all environment variables..."

# Deploy
echo ""
echo "🚀 Deploying to production..."
vercel --prod

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Next steps:"
echo "  1. Visit your Vercel URL and navigate to /scan"
echo "  2. Test scanning a book barcode"
echo "  3. Check your email for scan logs"
echo ""
echo "Useful commands:"
echo "  vercel logs          - View deployment logs"
echo "  vercel env ls        - List environment variables"
echo "  vercel --prod        - Redeploy to production"
