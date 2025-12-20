# Supabase Database Setup Guide

## 🚀 Quick Setup (Automated)

Run the automated setup script:
```bash
./setup-supabase-complete.sh
```

This will:
1. Install Supabase CLI (if needed)
2. Login to Supabase
3. Create or link a project
4. Apply database schema
5. Guide you through getting credentials

## 📋 Manual Setup Steps

### 1. Install Supabase CLI

**macOS (Homebrew - Recommended):**
```bash
brew install supabase/tap/supabase
```

**Other methods:**
- See: https://supabase.com/docs/guides/cli/getting-started

**Note:** Supabase CLI requires Docker for local development.

### 2. Login to Supabase

```bash
supabase login
```

This will open a browser for authentication.

### 3. Create a New Project

**Option A: Create via CLI**
```bash
# List your organizations
supabase orgs list

# Create project
supabase projects create ink-letter-books --org-id YOUR_ORG_ID
```

**Option B: Create via Dashboard (Easier)**
1. Go to https://supabase.com/dashboard
2. Click "New Project"
3. Fill in project details
4. Wait for project to be created

### 4. Link Your Project

```bash
# Get your project reference ID from dashboard
supabase link --project-ref YOUR_PROJECT_REF
```

### 5. Apply Database Schema

```bash
# Initialize Supabase in your project (if not done)
supabase init

# Create migrations directory
mkdir -p supabase/migrations

# Copy schema
cp admin/supabase/schema.sql supabase/migrations/20241205000000_initial_schema.sql

# Apply to remote database
supabase db push
```

### 6. Get Your Credentials

1. Go to https://supabase.com/dashboard
2. Select your project
3. Go to **Settings → API**
4. Copy:
   - **Project URL** → `NEXT_PUBLIC_SUPABASE_URL`
   - **Anon/Public Key** → `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### 7. Add Credentials to Environment Files

**Frontend (`frontend/.env.local`):**
```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Admin (`admin/.env.local`):**
```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
NEXT_PUBLIC_ADMIN_PASSWORD=your_secure_password
```

## 🗄️ Local Development (Optional)

For local development with Supabase:

```bash
# Start local Supabase
supabase start

# This provides:
# - Local database
# - Local API
# - Supabase Studio at http://localhost:54323
```

## 📊 Populate Sample Data

After setup, populate with sample books:

```bash
cd admin/scripts
export NEXT_PUBLIC_SUPABASE_URL="your_url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_key"
./run-populate.sh
```

## ✅ Verify Setup

1. Check Supabase Dashboard → Table Editor
2. You should see tables: `books`, `inventory`, `sales`, etc.
3. Run sample data script
4. Check admin system - books should appear
5. Check frontend - books should show on homepage

## 🔧 Troubleshooting

**"Docker not found"**
- Install Docker Desktop: https://www.docker.com/products/docker-desktop

**"Project not found"**
- Make sure you're logged in: `supabase login`
- Check project reference ID in dashboard

**"Schema errors"**
- Make sure you're using the correct schema file
- Check Supabase Dashboard → SQL Editor for errors

**"Connection errors"**
- Verify credentials in .env files
- Check project is active in dashboard
- Ensure database password is set

## 📚 Useful Commands

```bash
# Check status
supabase status

# View logs
supabase logs

# Reset local database
supabase db reset

# Generate TypeScript types
supabase gen types typescript --local > types/supabase.ts
```

## 🎯 Next Steps

1. ✅ Database created
2. ✅ Schema applied
3. ✅ Credentials configured
4. ✅ Sample data populated
5. 🚀 Start building!


