#!/bin/bash

echo "🚀 Setting up Supabase for Ink Letter Books"
echo ""

# Check if Supabase CLI is installed
if ! command -v supabase &> /dev/null; then
    echo "❌ Supabase CLI not found!"
    echo ""
    echo "Installing Supabase CLI..."
    echo ""
    echo "Choose installation method:"
    echo "1. Homebrew (macOS)"
    echo "2. npm"
    echo "3. Manual (see https://supabase.com/docs/guides/cli)"
    echo ""
    read -p "Enter choice (1-3): " choice
    
    case $choice in
        1)
            if command -v brew &> /dev/null; then
                brew install supabase/tap/supabase
            else
                echo "❌ Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        2)
            if command -v npm &> /dev/null; then
                npm install -g supabase
            else
                echo "❌ npm not found. Please install Node.js first."
                exit 1
            fi
            ;;
        3)
            echo "Please install Supabase CLI manually from:"
            echo "https://supabase.com/docs/guides/cli"
            exit 1
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
fi

echo "✅ Supabase CLI found!"
echo ""

# Check if already initialized
if [ -d "supabase" ]; then
    echo "ℹ️  Supabase already initialized in this directory"
    read -p "Do you want to reinitialize? (y/N): " reinit
    if [[ ! $reinit =~ ^[Yy]$ ]]; then
        echo "Skipping initialization..."
    else
        echo "Initializing Supabase..."
        supabase init
    fi
else
    echo "Initializing Supabase..."
    supabase init
fi

echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Login to Supabase:"
echo "   supabase login"
echo ""
echo "2. Link to your project (or create new):"
echo "   supabase link --project-ref YOUR_PROJECT_REF"
echo "   OR"
echo "   supabase projects create ink-letter-books"
echo ""
echo "3. Apply database schema:"
echo "   mkdir -p supabase/migrations"
echo "   cp admin/supabase/schema.sql supabase/migrations/20241205000000_initial_schema.sql"
echo "   supabase db push"
echo ""
echo "4. Get your credentials from Supabase Dashboard:"
echo "   - Go to Project Settings → API"
echo "   - Copy Project URL and Anon Key"
echo "   - Add to .env files"
echo ""
echo "5. Populate sample data:"
echo "   cd admin/scripts"
echo "   ./run-populate.sh"
echo ""
echo "🎉 Setup complete!"



