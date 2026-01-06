#!/bin/bash

echo "🚀 Complete Database Setup and Testing"
echo "======================================"
echo ""

# Step 1: Get credentials
if [ ! -f ".db-credentials" ]; then
    echo "📝 Step 1: Setting up credentials"
    echo "---------------------------------"
    echo ""
    echo "Please enter your Supabase credentials:"
    echo "(Get them from: https://supabase.com/dashboard/project/jdntczidspqkmtnwuxdb → Settings → API)"
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
    echo "✅ Found existing credentials"
    echo ""
fi

# Load credentials
source .db-credentials
export NEXT_PUBLIC_SUPABASE_URL
export NEXT_PUBLIC_SUPABASE_ANON_KEY

if [ -z "$NEXT_PUBLIC_SUPABASE_URL" ] || [ -z "$NEXT_PUBLIC_SUPABASE_ANON_KEY" ]; then
    echo "❌ Error: Credentials not found"
    exit 1
fi

# Step 2: Test database
echo "🧪 Step 2: Testing Database Connection"
echo "--------------------------------------"
node test-db-complete.js

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Database test failed!"
    exit 1
fi

# Step 3: Populate data
echo ""
echo "📊 Step 3: Populating Sample Data"
echo "----------------------------------"
cd admin/scripts
export NEXT_PUBLIC_SUPABASE_URL
export NEXT_PUBLIC_SUPABASE_ANON_KEY
./run-populate.sh
cd ../..

# Step 4: Verify data
echo ""
echo "✅ Step 4: Verifying Data"
echo "------------------------"
node -e "
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY);
(async () => {
  const { count } = await supabase.from('books').select('*', { count: 'exact', head: true });
  const { count: invCount } = await supabase.from('inventory').select('*', { count: 'exact', head: true });
  console.log('   📚 Books in database:', count || 0);
  console.log('   📦 Inventory items:', invCount || 0);
  if ((count || 0) > 0) {
    console.log('   ✅ Data populated successfully!');
  }
})();
"

# Step 5: Instructions
echo ""
echo "🎯 Step 5: Next Steps for Frontend"
echo "----------------------------------"
echo ""
echo "To see books on your frontend, add credentials to Vercel:"
echo ""
echo "1. Go to: https://vercel.com/dashboard"
echo "2. Select 'frontend' project"
echo "3. Settings → Environment Variables"
echo "4. Add these variables:"
echo "   NEXT_PUBLIC_SUPABASE_URL=$NEXT_PUBLIC_SUPABASE_URL"
echo "   NEXT_PUBLIC_SUPABASE_ANON_KEY=$NEXT_PUBLIC_SUPABASE_ANON_KEY"
echo "5. Redeploy the project"
echo ""
echo "Then check:"
echo "  📖 Exchange: https://frontend-xou3j7mhq-blindls-projects.vercel.app/exchange"
echo "  🏠 Homepage: https://frontend-xou3j7mhq-blindls-projects.vercel.app"
echo "  🔍 Search: https://frontend-xou3j7mhq-blindls-projects.vercel.app/search"
echo ""
echo "🎉 Setup complete!"



