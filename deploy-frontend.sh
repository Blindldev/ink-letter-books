#!/bin/bash

echo "🚀 Deploying Ink Letter Books Frontend to Vercel..."
echo ""

cd frontend

echo "📦 Building project..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed. Please fix errors and try again."
    exit 1
fi

echo ""
echo "🌐 Deploying to Vercel..."
echo ""

vercel --prod

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📝 Next steps:"
echo "1. Your site is now live on Vercel!"
echo "2. Add environment variables in Vercel Dashboard if needed"
echo "3. Share the URL to view your bookstore!"


