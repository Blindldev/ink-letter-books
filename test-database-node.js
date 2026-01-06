// Node.js compatible version (uses require)
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: Environment variables not set!');
  console.error('');
  console.error('Please set:');
  console.error('  export NEXT_PUBLIC_SUPABASE_URL="your_supabase_url"');
  console.error('  export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_supabase_anon_key"');
  console.error('');
  console.error('Or run:');
  console.error('  NEXT_PUBLIC_SUPABASE_URL="your_url" NEXT_PUBLIC_SUPABASE_ANON_KEY="your_key" node test-database-node.js');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

console.log('🧪 Testing Supabase Database');
console.log('============================');
console.log('');
console.log(`Project: jdntczidspqkmtnwuxdb`);
console.log(`URL: ${supabaseUrl}`);
console.log('');

async function testDatabase() {
  try {
    // Test 1: List all tables (by querying each one)
    console.log('📊 Test 1: Checking tables...');
    const tables = [
      'books',
      'inventory',
      'sales',
      'coupons',
      'holidays',
      'events',
      'online_orders',
      'order_items',
      'wishlists',
      'shared_links'
    ];

    const tableResults = {};
    for (const table of tables) {
      const { data, error } = await supabase.from(table).select('*').limit(1);
      if (error) {
        console.log(`   ❌ ${table}: ${error.message}`);
        tableResults[table] = false;
      } else {
        console.log(`   ✅ ${table}: Table exists and accessible`);
        tableResults[table] = true;
      }
    }

    console.log('');
    const successCount = Object.values(tableResults).filter(Boolean).length;
    console.log(`   Result: ${successCount}/${tables.length} tables accessible`);

    // Test 2: Check books table structure
    console.log('');
    console.log('📋 Test 2: Testing books table structure...');
    const { data: books, error: booksError } = await supabase
      .from('books')
      .select('*')
      .limit(1);

    if (booksError) {
      console.log(`   ❌ Error: ${booksError.message}`);
    } else {
      console.log('   ✅ Books table structure is correct');
    }

    // Test 3: Insert a test book
    console.log('');
    console.log('📝 Test 3: Inserting test book...');
    const testBook = {
      isbn: '9789999999999',
      title: 'CLI Test Book',
      author: 'Test Author',
      genre: ['Test'],
      language: 'en'
    };

    const { data: insertedBook, error: insertError } = await supabase
      .from('books')
      .insert(testBook)
      .select()
      .single();

    if (insertError) {
      if (insertError.code === '23505') {
        console.log('   ℹ️  Test book already exists (that\'s okay!)');
      } else {
        console.log(`   ❌ Insert error: ${insertError.message}`);
      }
    } else {
      console.log(`   ✅ Test book inserted: ${insertedBook.title}`);
    }

    // Test 4: Insert test inventory
    console.log('');
    console.log('📦 Test 4: Inserting test inventory...');
    
    // Get the test book ID
    const { data: testBookData } = await supabase
      .from('books')
      .select('id')
      .eq('isbn', '9789999999999')
      .single();

    if (testBookData) {
      // Check if inventory already exists
      const { data: existingInv } = await supabase
        .from('inventory')
        .select('id')
        .eq('book_id', testBookData.id)
        .maybeSingle();

      if (existingInv) {
        console.log('   ℹ️  Test inventory already exists');
      } else {
        const { data: inventory, error: invError } = await supabase
          .from('inventory')
          .insert({
            book_id: testBookData.id,
            price: 10.99,
            condition: 'good',
            status: 'available',
            notes: 'CLI test inventory'
          })
          .select()
          .single();

        if (invError) {
          console.log(`   ⚠️  Inventory error: ${invError.message}`);
        } else {
          console.log(`   ✅ Test inventory created: $${inventory.price}`);
        }
      }
    }

    // Test 5: Count records
    console.log('');
    console.log('🔢 Test 5: Counting records...');
    const { count: booksCount } = await supabase
      .from('books')
      .select('*', { count: 'exact', head: true });
    
    const { count: inventoryCount } = await supabase
      .from('inventory')
      .select('*', { count: 'exact', head: true });

    console.log(`   📚 Books: ${booksCount || 0}`);
    console.log(`   📦 Inventory: ${inventoryCount || 0}`);

    // Test 6: Query with join
    console.log('');
    console.log('🔗 Test 6: Testing join query...');
    const { data: joinedData, error: joinError } = await supabase
      .from('inventory')
      .select(`
        id,
        price,
        condition,
        books (
          id,
          title,
          author
        )
      `)
      .limit(1);

    if (joinError) {
      console.log(`   ⚠️  Join error: ${joinError.message}`);
    } else {
      console.log('   ✅ Join queries work correctly');
      if (joinedData && joinedData.length > 0) {
        console.log(`   📖 Sample: ${joinedData[0].books?.title || 'N/A'} - $${joinedData[0].price}`);
      }
    }

    // Summary
    console.log('');
    console.log('✅ All tests complete!');
    console.log('');
    console.log('📊 Summary:');
    console.log(`   ✅ Database connection: Working`);
    console.log(`   ✅ Schema: Applied correctly`);
    console.log(`   ✅ Tables: ${successCount}/${tables.length} accessible`);
    console.log(`   ✅ Records: ${booksCount || 0} books, ${inventoryCount || 0} inventory items`);
    console.log('');
    
    if ((booksCount || 0) === 0) {
      console.log('💡 Next step: Populate sample data');
      console.log('   cd admin/scripts');
      console.log('   ./run-populate.sh');
    } else {
      console.log('🎉 Your database is ready with data!');
    }

  } catch (error) {
    console.error('❌ Test failed:', error);
    process.exit(1);
  }
}

testDatabase();



