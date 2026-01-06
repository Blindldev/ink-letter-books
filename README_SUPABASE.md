# 🗄️ Supabase Database Setup

## ⚡ Fastest Way (Recommended)

**Use the Supabase Dashboard** - No CLI needed!

1. Go to: https://supabase.com/dashboard
2. Create new project
3. Apply schema from `admin/supabase/schema.sql`
4. Get credentials
5. Done!

See `CREATE_SUPABASE_DB.md` for detailed steps.

## 🚀 Quick Setup Script

Run:
```bash
./quick-setup-db.sh
```

This will guide you through the setup process.

## 📋 What You Need

1. **Supabase Account** (free tier available)
2. **Database Schema** (already created in `admin/supabase/schema.sql`)
3. **Credentials** (from Supabase Dashboard)

## ✅ After Setup

1. Add credentials to `.env.local` files
2. Run sample data script: `cd admin/scripts && ./run-populate.sh`
3. Start your apps and test!

## 📚 Full Documentation

- `CREATE_SUPABASE_DB.md` - Complete setup guide
- `SUPABASE_SETUP.md` - CLI setup details
- `admin/supabase/schema.sql` - Database schema



