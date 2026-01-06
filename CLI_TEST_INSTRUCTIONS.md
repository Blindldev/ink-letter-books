# Test Database via CLI-style Testing

Since Supabase CLI requires updated Command Line Tools, I've created a comprehensive test script that tests your database the same way CLI would.

## 🚀 Quick Test

### Option 1: Interactive Script (Easiest)

```bash
./run-db-test.sh
```

This will prompt for your credentials and run all tests.

### Option 2: With Environment Variables

```bash
export NEXT_PUBLIC_SUPABASE_URL="your_supabase_url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_supabase_anon_key"
node test-db-complete.js
```

### Option 3: One-liner

```bash
NEXT_PUBLIC_SUPABASE_URL="your_url" NEXT_PUBLIC_SUPABASE_ANON_KEY="your_key" node test-db-complete.js
```

## 📋 What Gets Tested

The script runs 10 comprehensive tests:

1. ✅ **Database Connection** - Verifies you can connect
2. ✅ **List All Tables** - Checks all 10 tables exist
3. ✅ **Table Structures** - Verifies schema is correct
4. ✅ **Insert Operations** - Tests adding records
5. ✅ **Query Operations** - Tests reading data
6. ✅ **Join Queries** - Tests relationships between tables
7. ✅ **Update Operations** - Tests modifying records
8. ✅ **Foreign Keys** - Tests table relationships
9. ✅ **Data Types** - Tests arrays, constraints, etc.
10. ✅ **Record Counts** - Shows data in all tables

## 📊 Expected Output

You'll see:
- ✅/❌ for each test
- Table accessibility checks
- Record counts
- Sample data
- Final summary with pass/fail counts

## 🎯 Get Your Credentials

1. Go to: https://supabase.com/dashboard/project/jdntczidspqkmtnwuxdb
2. Click **Settings → API**
3. Copy:
   - **Project URL**
   - **Anon/Public Key**

## ✅ After Tests Pass

If all tests pass:
1. Your database is ready! ✅
2. Populate sample data: `cd admin/scripts && ./run-populate.sh`
3. Start testing your apps!



