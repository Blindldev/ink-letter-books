# 🚀 Setup Instructions for Collaborators

Welcome! This guide will help you get the Ink Letter Books project running on your machine.

## 📋 Prerequisites

- Node.js 18+ installed
- Git installed
- A code editor (Cursor recommended)
- Supabase account (for database access)

## 🔽 Step 1: Clone the Repository

```bash
git clone <REPOSITORY_URL>
cd Bookstore
```

## 📦 Step 2: Install Dependencies

```bash
# Install root dependencies
npm install

# Install admin dependencies
cd admin
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

## 🔐 Step 3: Set Up Environment Variables

### For Admin System

Create `admin/.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_ADMIN_PASSWORD=your_admin_password
NEXT_PUBLIC_SITE_URL=http://localhost:3001
```

### For Frontend

Create `frontend/.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_key
STRIPE_SECRET_KEY=your_stripe_secret
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

**Get credentials from:**
- Supabase: https://supabase.com/dashboard/project/jdntczidspqkmtnwuxdb → Settings → API
- Stripe: https://stripe.com/dashboard → Developers → API keys

## 🗄️ Step 4: Database Setup

The database schema is already applied. If you need to verify:

1. Go to Supabase Dashboard
2. Check Table Editor - you should see 10 tables
3. If needed, run `admin/supabase/schema.sql` in SQL Editor

## 🚀 Step 5: Run the Applications

### Start Frontend (Customer Website)
```bash
cd frontend
npm run dev
```
Visit: http://localhost:3000

### Start Admin System
```bash
cd admin
npm run dev
```
Visit: http://localhost:3001

## 📊 Step 6: Populate Sample Data (Optional)

To add test books to the database:

```bash
cd admin/scripts
export NEXT_PUBLIC_SUPABASE_URL="your_url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_key"
./run-populate.sh
```

## 🧪 Step 7: Test Database Connection

```bash
# Set credentials
export NEXT_PUBLIC_SUPABASE_URL="your_url"
export NEXT_PUBLIC_SUPABASE_ANON_KEY="your_key"

# Run test
node test-db-complete.js
```

## 📁 Project Structure

```
Bookstore/
├── admin/              # Backend management system
│   ├── app/            # Next.js pages
│   ├── components/     # React components
│   ├── scripts/        # Database scripts
│   └── supabase/       # Database schema
├── frontend/           # Customer-facing website
│   ├── app/            # Next.js pages and routes
│   └── components/     # React components
└── Documentation files
```

## 🔑 Important Files

- `admin/supabase/schema.sql` - Database schema
- `admin/scripts/populate-sample-data-node.js` - Sample data script
- `SECRETS_NEEDED.md` - All required API keys
- `DEPLOYMENT.md` - Deployment instructions

## 🐛 Troubleshooting

### "Module not found"
- Run `npm install` in the specific directory
- Check Node.js version: `node --version` (should be 18+)

### "Database connection error"
- Verify credentials in `.env.local` files
- Check Supabase project is active
- Test connection: `node test-db-complete.js`

### "Port already in use"
- Change port in `package.json` or kill the process using the port

## 📚 Documentation

- `README.md` - Project overview
- `DEPLOYMENT.md` - How to deploy
- `SECRETS_NEEDED.md` - Required credentials
- `IMPLEMENTATION_NOTES.md` - Additional notes

## 🎯 Quick Commands

```bash
# Run both apps
npm run dev:frontend    # Terminal 1
npm run dev:admin       # Terminal 2

# Test database
node test-db-complete.js

# Populate data
cd admin/scripts && ./run-populate.sh
```

## ✅ Verification Checklist

- [ ] Repository cloned
- [ ] Dependencies installed
- [ ] Environment variables set
- [ ] Database accessible
- [ ] Frontend runs on localhost:3000
- [ ] Admin runs on localhost:3001
- [ ] Can see books on frontend

## 🆘 Need Help?

Check the documentation files or contact the project owner.

Happy coding! 🎉

