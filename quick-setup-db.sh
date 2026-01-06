#!/bin/bash

echo "🚀 Quick Supabase Database Setup"
echo "================================"
echo ""
echo "This script will guide you through creating a Supabase database."
echo ""

# Check if user wants to use Dashboard or CLI
echo "Choose setup method:"
echo "1. Dashboard (Recommended - Easiest, no CLI needed)"
echo "2. CLI (Advanced - requires Docker and CLI installation)"
echo ""
read -p "Enter choice (1 or 2): " method

case $method in
    1)
        echo ""
        echo "📋 Dashboard Setup Instructions"
        echo "=============================="
        echo ""
        echo "1. Open: https://supabase.com/dashboard"
        echo "2. Sign up/Login"
        echo "3. Click 'New Project'"
        echo "4. Fill in:"
        echo "   - Name: ink-letter-books"
        echo "   - Database Password: (choose strong password)"
        echo "   - Region: (choose closest)"
        echo "5. Wait 2-3 minutes for setup"
        echo ""
        echo "6. Get credentials:"
        echo "   - Go to Settings → API"
        echo "   - Copy Project URL and Anon Key"
        echo ""
        echo "7. Apply schema:"
        echo "   - Go to SQL Editor"
        echo "   - Copy contents of: admin/supabase/schema.sql"
        echo "   - Paste and Run"
        echo ""
        read -p "Press Enter when done..."
        
        echo ""
        echo "8. Add credentials to .env files:"
        read -p "Enter Project URL: " supabase_url
        read -p "Enter Anon Key: " supabase_key
        
        # Create .env files
        echo "Creating environment files..."
        
        # Frontend
        cat > frontend/.env.local << EOF
NEXT_PUBLIC_SUPABASE_URL=$supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=$supabase_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_placeholder
STRIPE_SECRET_KEY=sk_test_placeholder
NEXT_PUBLIC_SITE_URL=http://localhost:3000
EOF

        # Admin
        read -p "Enter admin password: " admin_password
        cat > admin/.env.local << EOF
NEXT_PUBLIC_SUPABASE_URL=$supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=$supabase_key
NEXT_PUBLIC_ADMIN_PASSWORD=$admin_password
NEXT_PUBLIC_SITE_URL=http://localhost:3001
EOF

        echo ""
        echo "✅ Environment files created!"
        echo ""
        echo "9. Populate sample data:"
        echo "   cd admin/scripts"
        echo "   export NEXT_PUBLIC_SUPABASE_URL=\"$supabase_url\""
        echo "   export NEXT_PUBLIC_SUPABASE_ANON_KEY=\"$supabase_key\""
        echo "   ./run-populate.sh"
        echo ""
        ;;
    2)
        echo ""
        echo "📋 CLI Setup"
        echo "==========="
        echo ""
        echo "Running automated CLI setup..."
        ./setup-supabase-complete.sh
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "🎉 Setup instructions complete!"
echo ""
echo "Next: Populate sample data and start your apps!"



