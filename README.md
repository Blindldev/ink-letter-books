# Ink Letter Books - Complete Bookstore System

A fully operational bookstore website and management system built with Next.js, TypeScript, and Supabase.

## 📚 Project Overview

This monorepo contains two main applications:

1. **Admin System** (`/admin`) - Backend database management tool for inventory and checkout
2. **Frontend Website** (`/frontend`) - Customer-facing website (ILbooks.com)

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- npm or yarn
- Supabase account
- Git

### Installation

```bash
# Clone repository
git clone <repository-url>
cd Bookstore

# Install dependencies
npm install
cd admin && npm install
cd ../frontend && npm install
```

### Environment Setup

1. **Admin** - Create `admin/.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_ADMIN_PASSWORD=your_admin_password
```

2. **Frontend** - Create `frontend/.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_key
STRIPE_SECRET_KEY=your_stripe_secret
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

### Run Development Servers

```bash
# Frontend (Terminal 1)
npm run dev:frontend
# Visit: http://localhost:3000

# Admin (Terminal 2)
npm run dev:admin
# Visit: http://localhost:3001
```

## 📊 Database Setup

1. Create Supabase project at https://supabase.com
2. Run `admin/supabase/schema.sql` in SQL Editor
3. Populate sample data: `cd admin/scripts && ./run-populate.sh`

## 🎯 Features

### Admin System
- ✅ Password-protected admin interface
- ✅ Inventory mode with ISBN scanning
- ✅ Checkout mode with tax calculation
- ✅ Analytics dashboard
- ✅ Coupon management
- ✅ Sales tracking

### Frontend Website
- ✅ Beautiful landing page
- ✅ Advanced search and filters
- ✅ Book recommendations
- ✅ Shopping cart with Stripe
- ✅ Google OAuth authentication
- ✅ Wishlist functionality
- ✅ Events calendar
- ✅ Exchange program page

## 📁 Project Structure

```
Bookstore/
├── admin/              # Backend management system
│   ├── app/            # Next.js pages
│   ├── components/     # React components
│   ├── scripts/        # Database utilities
│   └── supabase/       # Database schema
├── frontend/           # Customer website
│   ├── app/            # Next.js pages and routes
│   └── components/     # React components
└── Documentation files
```

## 📚 Documentation

- `COLLABORATOR_SETUP.md` - Setup guide for new team members
- `DEPLOYMENT.md` - Deployment instructions
- `SECRETS_NEEDED.md` - Required API keys and credentials
- `CREATE_SUPABASE_DB.md` - Database setup guide
- `IMPLEMENTATION_NOTES.md` - Additional recommendations

## 🔧 Scripts

```bash
# Development
npm run dev:frontend    # Start frontend
npm run dev:admin       # Start admin

# Build
npm run build:frontend  # Build frontend
npm run build:admin     # Build admin

# Database
cd admin/scripts
./run-populate.sh       # Populate sample data
node test-db-complete.js  # Test database
```

## 🛠️ Tech Stack

- **Framework:** Next.js 16 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS
- **Database:** Supabase (PostgreSQL)
- **Authentication:** Google OAuth
- **Payments:** Stripe
- **Email:** AWS SES

## 🔐 Security

- Environment variables in `.env.local` (not committed)
- Admin system password protected
- API keys stored securely
- Row-level security in Supabase

## 📝 License

Private project - All rights reserved

## 👥 Collaborators

See `COLLABORATOR_SETUP.md` for setup instructions.

## 🆘 Support

For issues or questions, check the documentation files or contact the project owner.
