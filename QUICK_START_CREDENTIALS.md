# 🚀 Quick Start - Provide Credentials

## Easiest Way

Just run:
```bash
./complete-setup.sh
```

This will:
1. Prompt for your Supabase credentials
2. Test the database
3. Populate sample books
4. Give you instructions for Vercel

## 📋 What You Need

Get from: https://supabase.com/dashboard/project/jdntczidspqkmtnwuxdb → Settings → API

- **Project URL**: `https://jdntczidspqkmtnwuxdb.supabase.co`
- **Anon Key**: `eyJhbGci...` (long string)

## 🎯 Goal

After setup, you'll see books at:
- https://frontend-xou3j7mhq-blindls-projects.vercel.app/exchange

## ⚠️ Important

After populating data, you MUST add credentials to Vercel for the frontend to work:
1. Vercel Dashboard → Your Project → Settings → Environment Variables
2. Add the two variables
3. Redeploy

Then books will appear on your live site! 🎉



