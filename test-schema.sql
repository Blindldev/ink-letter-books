-- Quick test to verify schema is working
-- Run this in Supabase SQL Editor

-- Test 1: Insert a test book
INSERT INTO books (isbn, title, author, genre, language) 
VALUES ('9781234567890', 'Test Book', 'Test Author', ARRAY['Fiction'], 'en')
RETURNING id, isbn, title;

-- Test 2: Insert test inventory
-- (Replace BOOK_ID with the id from Test 1)
INSERT INTO inventory (book_id, price, condition, status)
VALUES (
  (SELECT id FROM books WHERE isbn = '9781234567890'),
  10.99,
  'good',
  'available'
)
RETURNING id, price, condition, status;

-- Test 3: Check if data was inserted
SELECT 
  b.title,
  b.author,
  i.price,
  i.condition,
  i.status
FROM books b
JOIN inventory i ON i.book_id = b.id
WHERE b.isbn = '9781234567890';

-- If all three queries work, your schema is perfect! ✅


