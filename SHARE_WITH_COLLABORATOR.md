# 📤 Share This Project with Collaborators

## 🚀 Quick Share Instructions

Send this to your collaborator:

---

## Welcome to Ink Letter Books Project!

### 🔽 Clone the Repository

```bash
git clone <YOUR_GITHUB_REPO_URL>
cd Bookstore
```

### 📋 Quick Setup

1. **Install dependencies:**
```bash
npm install
cd admin && npm install
cd ../frontend && npm install
```

2. **Set up environment variables:**
   - See `COLLABORATOR_SETUP.md` for detailed instructions
   - You'll need Supabase credentials (I'll share separately)

3. **Run the apps:**
```bash
# Terminal 1 - Frontend
cd frontend && npm run dev

# Terminal 2 - Admin  
cd admin && npm run dev
```

### 📚 Full Documentation

See `COLLABORATOR_SETUP.md` for complete setup instructions.

### 🔐 Credentials Needed

You'll need:
- Supabase URL and Anon Key (I'll share via secure channel)
- Optional: Stripe keys for payment testing
- Optional: AWS credentials for email features

### 🎯 Project Structure

- `admin/` - Backend management system
- `frontend/` - Customer-facing website
- `admin/supabase/schema.sql` - Database schema
- `admin/scripts/` - Database utilities

### ✅ Verification

After setup, verify:
- Frontend: http://localhost:3000
- Admin: http://localhost:3001
- Database connection works

---

## 🔒 Sharing Credentials Securely

**DO NOT commit credentials to git!**

Share credentials via:
- Secure messaging (Signal, encrypted email)
- Password manager share
- Environment variable file (send separately)

The `.env.local` files are already in `.gitignore`.

## 📝 What's Included

✅ Complete bookstore system
✅ Admin inventory management
✅ Customer website
✅ Database schema
✅ Sample data scripts
✅ Full documentation
✅ Deployment guides

## 🆘 Questions?

Check the documentation files or reach out!


