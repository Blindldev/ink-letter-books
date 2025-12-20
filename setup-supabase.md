# Setting Up Supabase Database

## Option 1: Using Supabase CLI (Recommended for Local Development)

### Install Supabase CLI

**macOS (using Homebrew):**
```bash
brew install supabase/tap/supabase
```

**Or using npm:**
```bash
npm install -g supabase
```

**Or using other methods:**
- See: https://supabase.com/docs/guides/cli

### Initialize Supabase Project

1. **Login to Supabase:**
```bash
supabase login
```

2. **Link to existing project or create new:**
```bash
# Link to existing project
supabase link --project-ref your-project-ref

# OR create a new project
supabase projects create your-project-name --org-id your-org-id
```

3. **Initialize local Supabase (for development):**
```bash
cd /Users/mvicente/Bookstore
supabase init
```

4. **Start local Supabase:**
```bash
supabase start
```

This will:
- Start a local Supabase instance
- Create local database
- Provide local credentials

### Apply Database Schema

1. **Copy schema to Supabase migrations:**
```bash
# Create migrations directory if it doesn't exist
mkdir -p supabase/migrations

# Copy your schema
cp admin/supabase/schema.sql supabase/migrations/20241205000000_initial_schema.sql
```

2. **Apply migrations:**
```bash
# For local
supabase db reset

# For remote (production)
supabase db push
```

## Option 2: Using Supabase Dashboard (Easier for Production)

1. Go to https://supabase.com
2. Sign up/Login
3. Click "New Project"
4. Fill in:
   - Project name: "ink-letter-books"
   - Database password: (choose a strong password)
   - Region: (choose closest to you)
5. Wait for project to be created
6. Go to SQL Editor
7. Copy and paste the contents of `admin/supabase/schema.sql`
8. Run the SQL

### Get Your Credentials

After creating the project:
1. Go to Project Settings → API
2. Copy:
   - Project URL
   - Anon/Public Key
3. Add to your `.env` files

## Quick Setup Script

I'll create a script to help you set this up automatically!


