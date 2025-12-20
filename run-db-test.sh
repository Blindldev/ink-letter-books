#!/bin/bash

echo "🧪 Database Test Runner"
echo "======================="
echo ""

# Check if credentials are provided
if [ -z "$NEXT_PUBLIC_SUPABASE_URL" ] || [ -z "$NEXT_PUBLIC_SUPABASE_ANON_KEY" ]; then
    echo "Enter your Supabase credentials:"
    echo ""
    read -p "Project URL: " SUPABASE_URL
    read -p "Anon Key: " SUPABASE_KEY
    echo ""
    
    export NEXT_PUBLIC_SUPABASE_URL="$SUPABASE_URL"
    export NEXT_PUBLIC_SUPABASE_ANON_KEY="$SUPABASE_KEY"
fi

echo "Testing database: jdntczidspqkmtnwuxdb"
echo ""

# Run the test
node test-db-complete.js


