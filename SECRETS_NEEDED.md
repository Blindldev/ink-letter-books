# Required Secrets and Passwords

## 🔐 Critical Information Needed for Full Implementation

### 1. **Supabase Database**
- **Project URL**: `https://xxxxx.supabase.co`
- **Anon/Public Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
- **Where to get**: https://supabase.com → Create project → Settings → API
- **Action Required**: 
  - Create Supabase account
  - Create new project
  - Run `admin/supabase/schema.sql` in SQL Editor
  - Copy URL and anon key

### 2. **Stripe Payment Processing**
- **Publishable Key**: `pk_test_...` or `pk_live_...`
- **Secret Key**: `sk_test_...` or `sk_live_...`
- **Where to get**: https://stripe.com → Dashboard → Developers → API keys
- **Action Required**:
  - Create Stripe account
  - Get test keys for development
  - Get live keys for production
  - Set up webhook endpoint for order completion

### 3. **AWS SES (Email Service)**
- **AWS Access Key ID**: `AKIAIOSFODNN7EXAMPLE`
- **AWS Secret Access Key**: `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`
- **AWS Region**: `us-east-1` (or your preferred region)
- **Where to get**: AWS Console → IAM → Create user with SES permissions
- **Action Required**:
  - Create AWS account
  - Go to SES (Simple Email Service)
  - Verify domain: `ILbooks.com` or verify email: `info@ILbooks.com`
  - Create IAM user with SES send permissions
  - Generate access keys

### 4. **Google OAuth (User Authentication)**
- **Client ID**: `xxxxx.apps.googleusercontent.com`
- **Client Secret**: `GOCSPX-xxxxx`
- **Where to get**: https://console.cloud.google.com → APIs & Services → Credentials
- **Action Required**:
  - Create Google Cloud project
  - Enable Google+ API
  - Create OAuth 2.0 credentials
  - Add authorized redirect URI: `https://ILbooks.com/auth/callback`
  - Add authorized redirect URI: `http://localhost:3000/auth/callback` (for dev)

### 5. **Admin System Password**
- **Password**: (You choose this - make it strong!)
- **Where to set**: `admin/.env.local` → `NEXT_PUBLIC_ADMIN_PASSWORD`
- **Action Required**:
  - Choose a strong password
  - Set in admin environment variables
  - This protects your entire admin system

### 6. **Google Maps API (Optional - for /visit page)**
- **API Key**: `AIzaSy...`
- **Where to get**: Google Cloud Console → APIs & Services → Credentials
- **Action Required**:
  - Enable Maps JavaScript API
  - Create API key
  - Restrict to your domain (optional but recommended)

### 7. **Domain Configuration**
- **Frontend Domain**: `ILbooks.com`
- **Admin Domain**: `admin.ILbooks.com` or separate domain
- **Action Required**:
  - Point domain to Vercel
  - Set up DNS records
  - Configure SSL (automatic with Vercel)

## 📝 Environment Variable Checklist

### Frontend (`frontend/.env.local`)
```env
✅ NEXT_PUBLIC_SUPABASE_URL=
✅ NEXT_PUBLIC_SUPABASE_ANON_KEY=
✅ NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=
✅ STRIPE_SECRET_KEY=
✅ NEXT_PUBLIC_SITE_URL=https://ILbooks.com
✅ NEXT_PUBLIC_GOOGLE_MAPS_API_KEY= (optional)
```

### Admin (`admin/.env.local`)
```env
✅ NEXT_PUBLIC_SUPABASE_URL=
✅ NEXT_PUBLIC_SUPABASE_ANON_KEY=
✅ NEXT_PUBLIC_ADMIN_PASSWORD= (choose a strong password!)
✅ NEXT_PUBLIC_SITE_URL=https://admin.ILbooks.com
```

### AWS SES Integration (for email sending)
You'll need to update these files to use AWS SES:
- `frontend/app/api/contact/route.ts`
- `frontend/app/api/share/route.ts`

Install AWS SDK:
```bash
cd frontend
npm install @aws-sdk/client-ses
```

## 🚀 Quick Start Checklist

1. [ ] Create Supabase account and project
2. [ ] Run database schema (`admin/supabase/schema.sql`)
3. [ ] Create Stripe account and get API keys
4. [ ] Create AWS account and set up SES
5. [ ] Create Google Cloud project and OAuth credentials
6. [ ] Set admin password
7. [ ] Configure all environment variables
8. [ ] Deploy frontend to Vercel
9. [ ] Deploy admin to Vercel (password protected)
10. [ ] Test all functionality

## ⚠️ Important Security Notes

- **Never commit** `.env.local` files to git
- **Use strong passwords** for admin system
- **Restrict API keys** to your domain when possible
- **Use production keys** only in production
- **Keep secrets secure** - use environment variables, not hardcoded values

## 📧 Email Configuration

The contact form and share feature require AWS SES to be configured. After setting up:

1. Verify your domain or email in AWS SES
2. Update the email sending code in:
   - `frontend/app/api/contact/route.ts`
   - `frontend/app/api/share/route.ts`

Example AWS SES integration:
```typescript
import { SESClient, SendEmailCommand } from '@aws-sdk/client-ses';

const ses = new SESClient({ region: process.env.AWS_REGION });
await ses.send(new SendEmailCommand({
  Source: 'info@ILbooks.com',
  Destination: { ToAddresses: ['info@ILbooks.com'] },
  Message: {
    Subject: { Data: 'Contact Form Submission' },
    Body: { Text: { Data: message } }
  }
}));
```

## 🎯 Next Steps After Getting Secrets

1. Add all environment variables to both projects
2. Test locally: `npm run dev:frontend` and `npm run dev:admin`
3. Deploy to Vercel
4. Test production deployment
5. Add initial data (holidays, events, coupons)



