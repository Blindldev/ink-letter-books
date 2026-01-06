-- Verification queries to check if schema was applied correctly
-- Run these in Supabase SQL Editor to verify your tables exist

-- Check all tables exist
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Check books table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'books'
ORDER BY ordinal_position;

-- Check inventory table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'inventory'
ORDER BY ordinal_position;

-- Count tables (should be 10+ tables)
SELECT COUNT(*) as table_count
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE';

-- Check if indexes were created
SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;



