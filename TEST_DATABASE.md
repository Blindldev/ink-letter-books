# Test Your Supabase Database

## 🧪 Quick Test (No CLI Needed)

Since your database is already set up at: https://supabase.com/dashboard/project/jdntczidspqkmtnwuxdb

### Option 1: Run Test Script

1. **Get your credentials from Supabase Dashboard:**
   - Go to Settings → API
   - Copy Project URL and Anon Key

2. **Run the test:**
```bash
# Set credentials
export NEXT_PUBLIC_SUPABASE_URL="your_supabase_url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_supabase_anon_key"

# Run test
node test-database-node.js
```

Or in one command:
```bash
NEXT_PUBLIC_SUPABASE_URL="your_url" NEXT_PUBLIC_SUPABASE_ANON_KEY="your_key" node test-database-node.js
```

### Option 2: Test via Supabase Dashboard

1. Go to **SQL Editor**
2. Run this query:

```sql
-- Count all tables
SELECT 
  'books' as table_name, COUNT(*) as count FROM books
UNION ALL SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL SELECT 'sales', COUNT(*) FROM sales
UNION ALL SELECT 'coupons', COUNT(*) FROM coupons
UNION ALL SELECT 'holidays', COUNT(*) FROM holidays
UNION ALL SELECT 'events', COUNT(*) FROM events
UNION ALL SELECT 'online_orders', COUNT(*) FROM online_orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'wishlists', COUNT(*) FROM wishlists
UNION ALL SELECT 'shared_links', COUNT(*) FROM shared_links
ORDER BY table_name;
```

3. You should see all tables with counts (probably 0 for now)

### Option 3: Test Insert

Run this in SQL Editor:

```sql
-- Insert test book
INSERT INTO books (isbn, title, author, genre, language) 
VALUES ('9781234567890', 'Test Book', 'Test Author', ARRAY['Fiction'], 'en')
RETURNING *;
```

If this works, your schema is perfect! ✅

## ✅ What the Test Checks

- ✅ All 10 tables exist and are accessible
- ✅ Table structures are correct
- ✅ Can insert records
- ✅ Can query records
- ✅ Join queries work
- ✅ Counts records

## 🎯 After Testing

If tests pass:
1. ✅ Database is ready
2. 📊 Populate sample data: `cd admin/scripts && ./run-populate.sh`
3. 🚀 Start your apps and test!


