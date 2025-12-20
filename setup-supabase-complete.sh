#!/bin/bash

echo "🚀 Complete Supabase Setup for Ink Letter Books"
echo "================================================"
echo ""

# Check for Docker (required for local Supabase)
if ! command -v docker &> /dev/null; then
    echo "⚠️  Docker not found. Supabase CLI requires Docker for local development."
    echo "   Please install Docker Desktop from: https://www.docker.com/products/docker-desktop"
    echo ""
    read -p "Do you want to continue anyway? (y/N): " continue
    if [[ ! $continue =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Install Supabase CLI
if ! command -v supabase &> /dev/null; then
    echo "📦 Installing Supabase CLI..."
    echo ""
    
    if command -v brew &> /dev/null; then
        echo "Using Homebrew..."
        brew install supabase/tap/supabase
    else
        echo "❌ Homebrew not found. Please install Supabase CLI manually:"
        echo "   https://supabase.com/docs/guides/cli"
        echo ""
        echo "Or install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
else
    echo "✅ Supabase CLI already installed"
fi

echo ""
echo "🔐 Step 1: Login to Supabase"
echo "----------------------------"
echo "You need to login to Supabase. This will open a browser window."
read -p "Press Enter to continue..."
supabase login

echo ""
echo "📁 Step 2: Initialize Supabase Project"
echo "--------------------------------------"
if [ -d "supabase" ]; then
    echo "ℹ️  Supabase directory already exists"
    read -p "Reinitialize? (y/N): " reinit
    if [[ $reinit =~ ^[Yy]$ ]]; then
        supabase init
    fi
else
    supabase init
fi

echo ""
echo "🌐 Step 3: Create or Link Project"
echo "---------------------------------"
echo "Choose an option:"
echo "1. Create a new Supabase project"
echo "2. Link to an existing project"
read -p "Enter choice (1 or 2): " choice

case $choice in
    1)
        echo ""
        echo "Creating new project..."
        read -p "Enter project name (default: ink-letter-books): " project_name
        project_name=${project_name:-ink-letter-books}
        
        # Get org ID
        echo ""
        echo "Fetching your organizations..."
        orgs=$(supabase orgs list 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo "$orgs"
            read -p "Enter organization ID: " org_id
            supabase projects create "$project_name" --org-id "$org_id"
        else
            echo "⚠️  Could not fetch organizations. Please create project manually:"
            echo "   Go to https://supabase.com/dashboard and create a new project"
            echo "   Then link it using: supabase link --project-ref YOUR_PROJECT_REF"
        fi
        ;;
    2)
        echo ""
        read -p "Enter your project reference ID: " project_ref
        supabase link --project-ref "$project_ref"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "📊 Step 4: Apply Database Schema"
echo "--------------------------------"
echo "Setting up database schema..."

# Create migrations directory
mkdir -p supabase/migrations

# Copy schema to migrations
if [ -f "admin/supabase/schema.sql" ]; then
    cp admin/supabase/schema.sql supabase/migrations/20241205000000_initial_schema.sql
    echo "✅ Schema copied to migrations"
    
    echo ""
    echo "Applying schema to database..."
    supabase db push
    
    if [ $? -eq 0 ]; then
        echo "✅ Database schema applied successfully!"
    else
        echo "❌ Error applying schema. You may need to run it manually in Supabase Dashboard"
    fi
else
    echo "⚠️  Schema file not found at admin/supabase/schema.sql"
    echo "   Please copy it manually to supabase/migrations/"
fi

echo ""
echo "📝 Step 5: Get Your Credentials"
echo "-------------------------------"
echo "Your Supabase credentials are needed for the application."
echo ""
echo "To get them:"
echo "1. Go to https://supabase.com/dashboard"
echo "2. Select your project"
echo "3. Go to Settings → API"
echo "4. Copy:"
echo "   - Project URL"
echo "   - Anon/Public Key"
echo ""
echo "Then add them to:"
echo "  - frontend/.env.local"
echo "  - admin/.env.local"
echo ""

# Try to get credentials from linked project
if [ -f "supabase/.temp/project-ref" ]; then
    project_ref=$(cat supabase/.temp/project-ref)
    echo "Your project reference: $project_ref"
    echo "Dashboard URL: https://supabase.com/dashboard/project/$project_ref"
fi

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Next steps:"
echo "1. Add Supabase credentials to .env files"
echo "2. Run sample data script:"
echo "   cd admin/scripts && ./run-populate.sh"
echo "3. Start your applications:"
echo "   npm run dev:frontend"
echo "   npm run dev:admin"
echo ""


