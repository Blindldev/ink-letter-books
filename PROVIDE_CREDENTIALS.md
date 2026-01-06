# 🔐 Provide Database Credentials

## Secure Method (Recommended)

I've created a secure way for you to provide credentials that won't be committed to git.

### Step 1: Create Credentials File

Run this command and enter your credentials when prompted:

```bash
./setup-and-test.sh
```

This will:
1. Create a `.db-credentials` file (already in .gitignore)
2. Test your database connection
3. Populate sample data
4. Verify everything works

### Step 2: Or Create Manually

Create a file called `.db-credentials` in the root directory:

```bash
cat > .db-credentials << 'EOF'
NEXT_PUBLIC_SUPABASE_URL=https://jdntczidspqkmtnwuxdb.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
EOF
```

**Get your credentials from:**
- https://supabase.com/dashboard/project/jdntczidspqkmtnwuxdb
- Settings → API
- Copy Project URL and Anon Key

### Step 3: Run Complete Setup

```bash
./setup-and-test.sh
```

This will:
- ✅ Test database connection
- ✅ Verify all tables
- ✅ Populate ~50 sample books
- ✅ Show you where to check on frontend

## 🎯 Goal: See Books on Exchange Page

After running the script, check:
- **Exchange Page**: https://frontend-xou3j7mhq-blindls-projects.vercel.app/exchange
- **Homepage**: https://frontend-xou3j7mhq-blindls-projects.vercel.app
- **Search**: https://frontend-xou3j7mhq-blindls-projects.vercel.app/search

## ⚠️ Important: Vercel Environment Variables

For the frontend to show books, you need to add credentials to Vercel:

1. Go to: https://vercel.com/dashboard
2. Select your `frontend` project
3. Go to **Settings → Environment Variables**
4. Add:
   - `NEXT_PUBLIC_SUPABASE_URL` = your Supabase URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = your Anon Key
5. **Redeploy** the project

After redeploy, your frontend will be able to fetch books from the database!

## 🔒 Security Note

The `.db-credentials` file is already in `.gitignore`, so it won't be committed to git. It's safe to use locally.



