#!/bin/bash

echo "🧪 Testing Supabase Database via CLI"
echo "===================================="
echo ""

PROJECT_REF="jdntczidspqkmtnwuxdb"

# Check if Supabase CLI is installed
if ! command -v supabase &> /dev/null; then
    echo "❌ Supabase CLI not found!"
    echo ""
    echo "Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install supabase/tap/supabase
    else
        echo "❌ Homebrew not found. Please install Supabase CLI manually."
        echo "   See: https://supabase.com/docs/guides/cli"
        exit 1
    fi
fi

echo "✅ Supabase CLI found: $(supabase --version)"
echo ""

# Check if already linked
if [ -f "supabase/.temp/project-ref" ]; then
    current_ref=$(cat supabase/.temp/project-ref 2>/dev/null || echo "")
    if [ "$current_ref" == "$PROJECT_REF" ]; then
        echo "✅ Already linked to project: $PROJECT_REF"
    else
        echo "ℹ️  Linking to project: $PROJECT_REF"
        supabase link --project-ref "$PROJECT_REF"
    fi
else
    echo "🔗 Linking to your Supabase project..."
    supabase link --project-ref "$PROJECT_REF"
fi

if [ $? -ne 0 ]; then
    echo ""
    echo "⚠️  Link failed. You may need to login first:"
    echo "   supabase login"
    exit 1
fi

echo ""
echo "📊 Testing Database Connection"
echo "-----------------------------"

# Test 1: List tables
echo ""
echo "Test 1: Listing tables..."
supabase db remote list 2>&1 | head -20

# Test 2: Check table structure
echo ""
echo "Test 2: Checking books table structure..."
supabase db remote describe books 2>&1 | head -30

# Test 3: Count records
echo ""
echo "Test 3: Counting records in tables..."
echo "Running SQL query..."

# Create a temporary SQL file
cat > /tmp/test_query.sql << 'EOF'
SELECT 
  'books' as table_name, COUNT(*) as record_count FROM books
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'coupons', COUNT(*) FROM coupons
UNION ALL
SELECT 'holidays', COUNT(*) FROM holidays
UNION ALL
SELECT 'events', COUNT(*) FROM events
UNION ALL
SELECT 'online_orders', COUNT(*) FROM online_orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'wishlists', COUNT(*) FROM wishlists
UNION ALL
SELECT 'shared_links', COUNT(*) FROM shared_links
ORDER BY table_name;
EOF

supabase db remote exec --file /tmp/test_query.sql 2>&1

# Test 4: Insert a test record
echo ""
echo "Test 4: Inserting test book..."
cat > /tmp/test_insert.sql << 'EOF'
INSERT INTO books (isbn, title, author, genre, language) 
VALUES ('9789999999999', 'CLI Test Book', 'Test Author', ARRAY['Test'], 'en')
ON CONFLICT (isbn) DO NOTHING
RETURNING id, isbn, title;
EOF

supabase db remote exec --file /tmp/test_insert.sql 2>&1

# Test 5: Verify insert
echo ""
echo "Test 5: Verifying test book exists..."
supabase db remote exec --sql "SELECT id, isbn, title FROM books WHERE isbn = '9789999999999';" 2>&1

echo ""
echo "✅ Database tests complete!"
echo ""
echo "If you see table structures and counts, your database is working correctly!"
echo ""
echo "Next: Populate with sample data:"
echo "  cd admin/scripts"
echo "  export NEXT_PUBLIC_SUPABASE_URL='your_url'"
echo "  export NEXT_PUBLIC_SUPABASE_ANON_KEY='your_key'"
echo "  ./run-populate.sh"


