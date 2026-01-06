# 🚀 Quick Share Guide - Send This to Your Collaborator

## For You (Project Owner)

### 1. Push to GitHub

```bash
# Create repo at: https://github.com/new
# Then run:
cd /Users/mvicente/Bookstore
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
git push -u origin main
```

### 2. Share Repository URL

Send: `https://github.com/YOUR_USERNAME/REPO_NAME`

### 3. Share Credentials Separately

Send via secure channel:
- Supabase URL: `https://jdntczidspqkmtnwuxdb.supabase.co`
- Supabase Anon Key: (from Dashboard → Settings → API)
- Admin password: (your choice)

---

## For Your Collaborator

### 📦 Clone & Setup

```bash
# 1. Clone
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
cd REPO_NAME

# 2. Install
npm install
cd admin && npm install
cd ../frontend && npm install

# 3. Set up environment (see COLLABORATOR_SETUP.md)
# 4. Run apps
cd frontend && npm run dev  # Terminal 1
cd admin && npm run dev     # Terminal 2
```

### 📚 Full Instructions

See `COLLABORATOR_SETUP.md` for complete setup guide.

### 🔐 Get Credentials

Ask project owner for:
- Supabase credentials
- Admin password
- Optional: Stripe/AWS keys

---

**That's it!** 🎉


