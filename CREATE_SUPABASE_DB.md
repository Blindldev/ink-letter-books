# Create Supabase Database - Complete Guide

## 🎯 Two Options: CLI or Dashboard

### Option 1: Using Supabase Dashboard (Easiest - No CLI Needed)

This is the **fastest way** to get started:

1. **Go to Supabase Dashboard:**
   - Visit: https://supabase.com
   - Sign up or Login

2. **Create New Project:**
   - Click "New Project"
   - Project Name: `ink-letter-books`
   - Database Password: (choose a strong password - save this!)
   - Region: Choose closest to you
   - Click "Create new project"
   - Wait 2-3 minutes for setup

3. **Get Your Credentials:**
   - Go to **Settings → API**
   - Copy:
     - **Project URL** (e.g., `https://xxxxx.supabase.co`)
     - **Anon/Public Key** (starts with `eyJhbGci...`)

4. **Apply Database Schema:**
   - Go to **SQL Editor**
   - Click "New Query"
   - Copy entire contents of `admin/supabase/schema.sql`
   - Paste into editor
   - Click "Run" (or press Cmd/Ctrl + Enter)
   - ✅ Schema applied!

5. **Add Credentials to .env files:**
   - `frontend/.env.local`
   - `admin/.env.local`

**Done!** Your database is ready. Skip to "Populate Sample Data" section.

---

### Option 2: Using Supabase CLI (For Advanced Users)

**Prerequisites:**
- Docker Desktop installed
- Command Line Tools updated (for macOS)

#### Step 1: Install Supabase CLI

**macOS:**
```bash
# Update Command Line Tools first (if needed):
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install

# Then install Supabase CLI:
brew install supabase/tap/supabase
```

**Verify installation:**
```bash
supabase --version
```

#### Step 2: Login

```bash
supabase login
```

This opens a browser for authentication.

#### Step 3: Create Project

**Via CLI:**
```bash
# List organizations
supabase orgs list

# Create project
supabase projects create ink-letter-books --org-id YOUR_ORG_ID
```

**Or create via Dashboard** (easier):
1. Go to https://supabase.com/dashboard
2. Create project there
3. Then link it:
```bash
supabase link --project-ref YOUR_PROJECT_REF
```

#### Step 4: Initialize and Apply Schema

```bash
# Initialize Supabase in your project
cd /Users/mvicente/Bookstore
supabase init

# Create migrations directory
mkdir -p supabase/migrations

# Copy schema
cp admin/supabase/schema.sql supabase/migrations/20241205000000_initial_schema.sql

# Apply to database
supabase db push
```

#### Step 5: Get Credentials

Same as Option 1 - get from Dashboard → Settings → API

---

## 📊 Populate Sample Data

After database is set up:

```bash
# Set credentials
export NEXT_PUBLIC_SUPABASE_URL="your_supabase_url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_supabase_anon_key"

# Run population script
cd admin/scripts
./run-populate.sh
```

This will add ~50 sample books to your database!

---

## ✅ Verify Everything Works

1. **Check Supabase Dashboard:**
   - Go to Table Editor
   - You should see: `books`, `inventory`, `sales`, `coupons`, etc.

2. **Check Admin System:**
   - Start admin: `npm run dev:admin`
   - Login with your admin password
   - Go to Inventory mode
   - You should see books!

3. **Check Frontend:**
   - Start frontend: `npm run dev:frontend`
   - Visit homepage
   - Books should appear!

---

## 🔧 Troubleshooting

### "Command Line Tools outdated"
```bash
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

### "Docker not found"
- Install Docker Desktop: https://www.docker.com/products/docker-desktop
- Start Docker Desktop
- Try again

### "Schema errors"
- Check SQL syntax in Supabase Dashboard → SQL Editor
- Look for error messages
- Common issues: missing quotes, wrong data types

### "Connection refused"
- Verify credentials are correct
- Check project is active (not paused)
- Ensure database password is set

---

## 🎯 Recommended: Use Dashboard Method

For getting started quickly, **use Option 1 (Dashboard)**:
- ✅ No CLI installation needed
- ✅ Visual interface
- ✅ Faster setup
- ✅ Easier to troubleshoot

You can always use CLI later for advanced features!

---

## 📝 Quick Reference

**Dashboard URL:** https://supabase.com/dashboard

**Schema File:** `admin/supabase/schema.sql`

**Sample Data Script:** `admin/scripts/run-populate.sh`

**Environment Variables Needed:**
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`


