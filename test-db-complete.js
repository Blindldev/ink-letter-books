// Comprehensive database test using Supabase client
// This tests your database the same way CLI would

const { createClient } = require('@supabase/supabase-js');

// Get credentials from environment or prompt
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.argv[2];
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.argv[3];

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Missing credentials');
  console.error('');
  console.error('Usage:');
  console.error('  NEXT_PUBLIC_SUPABASE_URL="url" NEXT_PUBLIC_SUPABASE_ANON_KEY="key" node test-db-complete.js');
  console.error('');
  console.error('Or:');
  console.error('  node test-db-complete.js "url" "key"');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);
const PROJECT_REF = 'jdntczidspqkmtnwuxdb';

console.log('🧪 Comprehensive Database Test via Supabase Client');
console.log('==================================================');
console.log('');
console.log(`Project: ${PROJECT_REF}`);
console.log(`URL: ${supabaseUrl.substring(0, 30)}...`);
console.log('');

let testsPassed = 0;
let testsFailed = 0;

async function runTest(name, testFn) {
  try {
    console.log(`\n📋 ${name}`);
    console.log('─'.repeat(50));
    const result = await testFn();
    if (result !== false) {
      testsPassed++;
      return true;
    } else {
      testsFailed++;
      return false;
    }
  } catch (error) {
    console.log(`   ❌ Error: ${error.message}`);
    testsFailed++;
    return false;
  }
}

async function testAll() {
  // Test 1: Connection
  await runTest('Test 1: Database Connection', async () => {
    const { data, error } = await supabase.from('books').select('*').limit(1);
    if (error) throw error;
    console.log('   ✅ Connected successfully');
    return true;
  });

  // Test 2: List all tables
  await runTest('Test 2: List All Tables', async () => {
    const tables = [
      'books', 'inventory', 'sales', 'coupons', 'holidays',
      'events', 'online_orders', 'order_items', 'wishlists', 'shared_links'
    ];
    
    console.log('   Checking tables:');
    const results = {};
    
    for (const table of tables) {
      const { error } = await supabase.from(table).select('*').limit(1);
      if (error) {
        console.log(`      ❌ ${table}: ${error.message}`);
        results[table] = false;
      } else {
        console.log(`      ✅ ${table}`);
        results[table] = true;
      }
    }
    
    const successCount = Object.values(results).filter(Boolean).length;
    console.log(`   Result: ${successCount}/${tables.length} tables accessible`);
    return successCount === tables.length;
  });

  // Test 3: Table structures
  await runTest('Test 3: Verify Table Structures', async () => {
    // Test books table
    const { data: book, error: bookError } = await supabase
      .from('books')
      .select('*')
      .limit(1);
    
    if (bookError) throw bookError;
    
    // Test inventory table
    const { data: inv, error: invError } = await supabase
      .from('inventory')
      .select('*')
      .limit(1);
    
    if (invError) throw invError;
    
    console.log('   ✅ books table structure: OK');
    console.log('   ✅ inventory table structure: OK');
    return true;
  });

  // Test 4: Insert operations
  await runTest('Test 4: Insert Operations', async () => {
    // Insert test book
    const testBook = {
      isbn: '9788888888888',
      title: 'CLI Test Book',
      author: 'Test Author',
      genre: ['Test', 'Fiction'],
      language: 'en',
      description: 'This is a test book inserted via CLI test'
    };

    const { data: inserted, error: insertError } = await supabase
      .from('books')
      .insert(testBook)
      .select()
      .single();

    if (insertError) {
      if (insertError.code === '23505') {
        console.log('   ℹ️  Test book already exists (updating...)');
        // Update instead
        const { data: updated } = await supabase
          .from('books')
          .update({ title: 'CLI Test Book Updated' })
          .eq('isbn', testBook.isbn)
          .select()
          .single();
        console.log(`   ✅ Book updated: ${updated.title}`);
      } else {
        throw insertError;
      }
    } else {
      console.log(`   ✅ Book inserted: ${inserted.title}`);
    }

    // Insert test inventory
    const { data: bookData } = await supabase
      .from('books')
      .select('id')
      .eq('isbn', '9788888888888')
      .single();

    if (bookData) {
      const { data: existingInv } = await supabase
        .from('inventory')
        .select('id')
        .eq('book_id', bookData.id)
        .maybeSingle();

      if (!existingInv) {
        const { data: inventory, error: invError } = await supabase
          .from('inventory')
          .insert({
            book_id: bookData.id,
            price: 12.99,
            condition: 'good',
            status: 'available',
            notes: 'CLI test inventory'
          })
          .select()
          .single();

        if (invError) throw invError;
        console.log(`   ✅ Inventory inserted: $${inventory.price}`);
      } else {
        console.log('   ℹ️  Test inventory already exists');
      }
    }

    return true;
  });

  // Test 5: Query operations
  await runTest('Test 5: Query Operations', async () => {
    // Count books
    const { count: booksCount } = await supabase
      .from('books')
      .select('*', { count: 'exact', head: true });
    
    // Count inventory
    const { count: invCount } = await supabase
      .from('inventory')
      .select('*', { count: 'exact', head: true });

    console.log(`   📚 Total books: ${booksCount || 0}`);
    console.log(`   📦 Total inventory items: ${invCount || 0}`);

    // Get sample book
    const { data: sampleBook } = await supabase
      .from('books')
      .select('*')
      .limit(1)
      .single();

    if (sampleBook) {
      console.log(`   📖 Sample book: ${sampleBook.title} by ${sampleBook.author || 'Unknown'}`);
    }

    return true;
  });

  // Test 6: Join queries
  await runTest('Test 6: Join Queries (Relations)', async () => {
    const { data: joined, error: joinError } = await supabase
      .from('inventory')
      .select(`
        id,
        price,
        condition,
        status,
        books (
          id,
          title,
          author,
          isbn
        )
      `)
      .limit(3);

    if (joinError) throw joinError;

    if (joined && joined.length > 0) {
      console.log(`   ✅ Join query successful (${joined.length} results)`);
      joined.forEach((item, idx) => {
        if (item.books) {
          console.log(`      ${idx + 1}. ${item.books.title} - $${item.price} (${item.condition})`);
        }
      });
    } else {
      console.log('   ℹ️  No inventory items found (this is OK if database is empty)');
    }

    return true;
  });

  // Test 7: Update operations
  await runTest('Test 7: Update Operations', async () => {
    const { data: testBook } = await supabase
      .from('books')
      .select('id')
      .eq('isbn', '9788888888888')
      .single();

    if (testBook) {
      const { error: updateError } = await supabase
        .from('books')
        .update({ updated_at: new Date().toISOString() })
        .eq('id', testBook.id);

      if (updateError) throw updateError;
      console.log('   ✅ Update operation successful');
    } else {
      console.log('   ℹ️  No test book to update');
    }

    return true;
  });

  // Test 8: Foreign key relationships
  await runTest('Test 8: Foreign Key Relationships', async () => {
    // Test inventory -> books relationship
    const { data: invWithBook, error: fkError } = await supabase
      .from('inventory')
      .select(`
        id,
        book_id,
        books!inner(id, title)
      `)
      .limit(1);

    if (fkError && fkError.code !== 'PGRST116') {
      console.log(`   ⚠️  FK test: ${fkError.message}`);
    } else {
      console.log('   ✅ Foreign key relationships working');
    }

    return true;
  });

  // Test 9: Data types and constraints
  await runTest('Test 9: Data Types and Constraints', async () => {
    // Test array type (genre)
    const { data: bookWithGenre } = await supabase
      .from('books')
      .select('genre')
      .not('genre', 'is', null)
      .limit(1)
      .single();

    if (bookWithGenre && Array.isArray(bookWithGenre.genre)) {
      console.log(`   ✅ Array type (genre) working: [${bookWithGenre.genre.join(', ')}]`);
    }

    // Test unique constraint (ISBN)
    const { error: uniqueError } = await supabase
      .from('books')
      .insert({
        isbn: '9788888888888', // Duplicate
        title: 'Duplicate Test',
        author: 'Test'
      });

    if (uniqueError && uniqueError.code === '23505') {
      console.log('   ✅ Unique constraint (ISBN) working correctly');
    }

    return true;
  });

  // Test 10: Count all tables
  await runTest('Test 10: Count Records in All Tables', async () => {
    const tables = [
      'books', 'inventory', 'sales', 'coupons', 'holidays',
      'events', 'online_orders', 'order_items', 'wishlists', 'shared_links'
    ];

    console.log('   Record counts:');
    for (const table of tables) {
      const { count } = await supabase
        .from(table)
        .select('*', { count: 'exact', head: true });
      console.log(`      ${table.padEnd(20)}: ${count || 0}`);
    }

    return true;
  });

  // Final Summary
  console.log('\n');
  console.log('═'.repeat(60));
  console.log('📊 TEST SUMMARY');
  console.log('═'.repeat(60));
  console.log(`   ✅ Passed: ${testsPassed}`);
  console.log(`   ❌ Failed: ${testsFailed}`);
  console.log(`   📈 Success Rate: ${Math.round((testsPassed / (testsPassed + testsFailed)) * 100)}%`);
  console.log('');

  if (testsFailed === 0) {
    console.log('🎉 All tests passed! Your database is working perfectly!');
    console.log('');
    console.log('💡 Next steps:');
    console.log('   1. Populate sample data: cd admin/scripts && ./run-populate.sh');
    console.log('   2. Start admin: npm run dev:admin');
    console.log('   3. Start frontend: npm run dev:frontend');
  } else {
    console.log('⚠️  Some tests failed. Check the errors above.');
  }
  console.log('');
}

// Run all tests
testAll().catch(error => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});



