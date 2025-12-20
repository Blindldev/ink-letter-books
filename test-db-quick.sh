#!/bin/bash
echo "🧪 Quick Database Test"
echo ""
echo "Enter your Supabase credentials:"
read -p "Project URL: " SUPABASE_URL
read -p "Anon Key: " SUPABASE_KEY
echo ""
echo "Testing connection..."
NEXT_PUBLIC_SUPABASE_URL="$SUPABASE_URL" NEXT_PUBLIC_SUPABASE_ANON_KEY="$SUPABASE_KEY" node test-database-node.js
