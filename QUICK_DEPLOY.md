# 🚀 Quick Deploy to Vercel

## Option 1: One-Command Deploy (Easiest)

Just run this from the Bookstore directory:

```bash
cd frontend && vercel --prod
```

Follow the prompts:
- **Set up and deploy?** → Type `Y` and press Enter
- **Which scope?** → Choose your account
- **Link to existing project?** → Type `N` (No) for first time
- **What's your project's name?** → Press Enter for default or type a name
- **In which directory is your code located?** → Press Enter (uses `./`)

**That's it!** Your site will be live in ~2 minutes.

## Option 2: Use the Deploy Script

```bash
./deploy-frontend.sh
```

## Option 3: Via Vercel Dashboard

1. Go to https://vercel.com and sign up/login
2. Click "Add New Project"
3. Import from GitHub (push your code first) OR
4. Use Vercel CLI: `vercel` (without --prod for preview)

## 📍 Your Site URL

After deployment, Vercel will give you a URL like:
- `https://ink-letter-books-xxxxx.vercel.app`

You can share this URL immediately to view your bookstore!

## ⚙️ Environment Variables (Optional for Now)

The site will work without them, but for full functionality, add in Vercel Dashboard:
- Settings → Environment Variables

Add:
```
NEXT_PUBLIC_SUPABASE_URL=placeholder
NEXT_PUBLIC_SUPABASE_ANON_KEY=placeholder
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=placeholder
STRIPE_SECRET_KEY=placeholder
NEXT_PUBLIC_SITE_URL=https://your-app.vercel.app
```

## 🎉 That's It!

Your bookstore is now live on the internet! Share the URL with anyone.


