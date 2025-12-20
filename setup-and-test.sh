#!/bin/bash

echo "🔐 Secure Database Setup and Testing"
echo "===================================="
echo ""

# Check for credentials file
if [ ! -f ".db-credentials" ]; then
    echo "📝 Creating credentials file..."
    echo ""
    echo "Please enter your Supabase credentials:"
    echo "(These will be saved to .db-credentials - already in .gitignore)"
    echo ""
    read -p "Supabase Project URL: " SUPABASE_URL
    read -p "Supabase Anon Key: " SUPABASE_KEY
    echo ""
    
    cat > .db-credentials << EOF
NEXT_PUBLIC_SUPABASE_URL=$SUPABASE_URL
NEXT_PUBLIC_SUPABASE_ANON_KEY=$SUPABASE_KEY
EOF
    
    echo "✅ Credentials saved to .db-credentials"
    echo ""
else
    echo "✅ Found existing credentials file"
    echo ""
fi

# Load credentials
source .db-credentials

if [ -z "$NEXT_PUBLIC_SUPABASE_URL" ] || [ -z "$NEXT_PUBLIC_SUPABASE_ANON_KEY" ]; then
    echo "❌ Error: Credentials not found in .db-credentials"
    exit 1
fi

echo "🧪 Step 1: Testing Database Connection"
echo "--------------------------------------"
export NEXT_PUBLIC_SUPABASE_URL
export NEXT_PUBLIC_SUPABASE_ANON_KEY
node test-db-complete.js

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Database test failed. Please check your credentials."
    exit 1
fi

echo ""
echo "📊 Step 2: Populating Sample Data"
echo "----------------------------------"
echo "This will add ~50 sample books to your database..."
echo ""

cd admin/scripts
export NEXT_PUBLIC_SUPABASE_URL
export NEXT_PUBLIC_SUPABASE_ANON_KEY
./run-populate.sh

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Sample data populated!"
    echo ""
    echo "🎯 Step 3: Verify on Frontend"
    echo "----------------------------"
    echo "Your frontend: https://frontend-xou3j7mhq-blindls-projects.vercel.app"
    echo ""
    echo "Check these pages:"
    echo "  - Homepage: https://frontend-xou3j7mhq-blindls-projects.vercel.app"
    echo "  - Exchange: https://frontend-xou3j7mhq-blindls-projects.vercel.app/exchange"
    echo "  - Search: https://frontend-xou3j7mhq-blindls-projects.vercel.app/search"
    echo ""
    echo "💡 Note: You may need to add credentials to Vercel environment variables"
    echo "   for the frontend to access the database."
fi


