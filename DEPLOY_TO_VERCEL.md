# Deploy to Vercel - Step by Step Guide

## 🚀 Quick Deployment (5 minutes)

### Option 1: Deploy via Vercel CLI (Recommended)

1. **Install Vercel CLI** (if not already installed):
```bash
npm install -g vercel
```

2. **Login to Vercel**:
```bash
vercel login
```

3. **Deploy the frontend**:
```bash
cd frontend
vercel
```

4. **Follow the prompts**:
   - Set up and deploy? **Yes**
   - Which scope? (Choose your account)
   - Link to existing project? **No**
   - Project name? **ink-letter-books** (or your choice)
   - Directory? **./** (press Enter)
   - Override settings? **No**

5. **Your site will be live!** Vercel will give you a URL like:
   - `https://ink-letter-books.vercel.app`

### Option 2: Deploy via GitHub + Vercel Dashboard

1. **Push to GitHub**:
```bash
cd /Users/mvicente/Bookstore
git init
git add .
git commit -m "Initial commit - Ink Letter Books"
git branch -M main
git remote add origin YOUR_GITHUB_REPO_URL
git push -u origin main
```

2. **Connect to Vercel**:
   - Go to https://vercel.com
   - Sign up/Login
   - Click "Add New Project"
   - Import your GitHub repository
   - Select the `frontend` folder as the root directory
   - Click "Deploy"

3. **Configure Environment Variables** (after first deploy):
   - Go to Project Settings → Environment Variables
   - Add all variables from `.env.example`
   - Redeploy

## 📝 Environment Variables Setup

After deployment, add these in Vercel Dashboard → Settings → Environment Variables:

```
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_key
STRIPE_SECRET_KEY=your_stripe_secret
NEXT_PUBLIC_SITE_URL=https://your-domain.vercel.app
```

**Note**: For now, you can use placeholder values to see the UI. The site will work but database features won't function.

## 🎯 Quick Deploy Command

Run this from the Bookstore directory:

```bash
cd frontend && vercel --prod
```

## 🔧 Troubleshooting

### If you get CSP errors:
- The `next.config.ts` has been updated to fix CSP issues
- Redeploy after making changes

### If build fails:
- Make sure all dependencies are installed: `npm install`
- Check that Node.js version is 18+ in Vercel settings

### Custom Domain:
- After deployment, go to Project Settings → Domains
- Add your custom domain (ILbooks.com)
- Update DNS records as instructed

## 📱 Deploy Admin System Separately

The admin system should be deployed as a separate Vercel project:

```bash
cd admin
vercel
```

Then password-protect it in Vercel Settings → Deployment Protection.

## ✅ After Deployment

1. Your site will be live at the Vercel URL
2. Share the URL to view it
3. Set up environment variables for full functionality
4. Connect custom domain when ready

Your bookstore will be live on the internet! 🎉



