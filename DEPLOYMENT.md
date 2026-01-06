# Deployment Guide

## Required Services and Credentials

### 1. Supabase (Database)
- **URL**: Create a new project at https://supabase.com
- **Anon Key**: Found in Project Settings > API
- **Steps**:
  1. Create a new Supabase project
  2. Run the SQL schema from `admin/supabase/schema.sql` in the SQL Editor
  3. Copy the Project URL and anon key

### 2. Stripe (Payments)
- **Publishable Key**: Found in Dashboard > Developers > API keys
- **Secret Key**: Found in Dashboard > Developers > API keys (keep this secret!)
- **Steps**:
  1. Create account at https://stripe.com
  2. Get your API keys from the dashboard
  3. Set up webhook endpoint: `/api/webhooks/stripe` (for production)

### 3. AWS SES (Email)
- **Region**: e.g., `us-east-1`
- **Access Key ID**: From AWS IAM
- **Secret Access Key**: From AWS IAM
- **Steps**:
  1. Create AWS account
  2. Go to SES (Simple Email Service)
  3. Verify domain: `ILbooks.com`
  4. Create IAM user with SES permissions
  5. Get access keys

### 4. Google OAuth (Authentication)
- **Client ID**: From Google Cloud Console
- **Client Secret**: From Google Cloud Console
- **Steps**:
  1. Go to https://console.cloud.google.com
  2. Create new project
  3. Enable Google+ API
  4. Create OAuth 2.0 credentials
  5. Add authorized redirect URI: `https://yourdomain.com/auth/callback`

### 5. Google Maps API (Optional)
- **API Key**: From Google Cloud Console
- **Steps**:
  1. Enable Maps JavaScript API in Google Cloud Console
  2. Create API key with domain restrictions

## Environment Variables

### Frontend (`.env.local`)
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
NEXT_PUBLIC_SITE_URL=https://ILbooks.com
NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=your_google_maps_api_key
```

### Admin (`.env.local`)
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
NEXT_PUBLIC_ADMIN_PASSWORD=your_secure_password_here
NEXT_PUBLIC_SITE_URL=https://admin.ILbooks.com
```

## Deployment Steps

### Frontend (Vercel)
1. Push code to GitHub
2. Import project in Vercel
3. Set environment variables
4. Deploy

### Admin (Vercel - Separate Project)
1. Create separate Vercel project for admin
2. Set environment variables
3. Deploy
4. Password protect the entire site in Vercel settings

### Database Setup
1. Run `admin/supabase/schema.sql` in Supabase SQL Editor
2. Set up Row Level Security (RLS) policies as needed
3. Insert initial data (holidays, events, etc.)

## Post-Deployment

1. **Configure Supabase RLS**: Set up row-level security policies
2. **Set up Stripe Webhooks**: Point to your production webhook URL
3. **Verify AWS SES**: Complete domain verification
4. **Test Google OAuth**: Test login flow
5. **Add Holidays**: Insert federal holidays into `holidays` table
6. **Add Events**: Insert weekly events into `events` table
7. **Create Coupons**: Add any promotional coupons to `coupons` table

## Important Notes

- **Admin Password**: Set a strong password for the admin system
- **Stripe**: Use test keys for development, production keys for production
- **Email**: AWS SES starts in sandbox mode - verify email addresses first
- **Domain**: Point `ILbooks.com` to Vercel deployment
- **Admin URL**: Use a subdomain or separate domain for admin (password protected)

## Security Checklist

- [ ] Strong admin password set
- [ ] Stripe keys are production keys (not test)
- [ ] AWS SES domain verified
- [ ] Google OAuth redirect URIs configured
- [ ] Supabase RLS policies configured
- [ ] Environment variables not committed to git
- [ ] HTTPS enabled on all domains



