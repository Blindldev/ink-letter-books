# Book Scanner - Quick Start Guide

## What Was Built

A comprehensive barcode scanning web app that:
- 📷 Scans ISBN barcodes using your phone's camera
- 📚 Fetches complete book details from Google Books & Open Library
- 📧 Emails detailed scan logs to Mikevicentecs@gmail.com via AWS SES
- 📱 Works on mobile devices (optimized for phones)

## Files Created/Modified

### New Files
- `frontend/app/scan/page.tsx` - Barcode scanner UI page
- `frontend/app/api/scan/route.ts` - Backend API for book data fetching & email logging
- `SCAN_APP_DEPLOYMENT.md` - Complete deployment guide
- `SCAN_APP_QUICK_START.md` - This file

### Modified Files
- `frontend/package.json` - Added `html5-qrcode` and `@aws-sdk/client-ses` dependencies
- `frontend/components/Header.tsx` - Added scan link to navigation
- `frontend/next.config.ts` - Added camera permissions and CSP updates

## Quick Deploy Steps (All via CLI)

### 1. Set Up AWS SES (Manual - One Time)

1. Go to [AWS Console](https://console.aws.amazon.com) → SES
2. Verify email: `Mikevicentecs@gmail.com`
3. Create IAM user with SES permissions
4. Save Access Key ID and Secret Access Key

### 2. Install Dependencies

```bash
cd frontend
npm install
```

### 3. Deploy to Vercel (CLI)

```bash
# Install Vercel CLI (if needed)
npm i -g vercel

# Login
vercel login

# Link project (first time)
vercel link

# Add environment variables
vercel env add AWS_ACCESS_KEY_ID
# Paste your AWS Access Key ID
# Select: Production, Preview, Development

vercel env add AWS_SECRET_ACCESS_KEY
# Paste your AWS Secret Access Key
# Select: Production, Preview, Development

vercel env add AWS_REGION
# Enter: us-east-1
# Select: Production, Preview, Development

vercel env add AWS_SES_FROM_EMAIL
# Enter: Mikevicentecs@gmail.com
# Select: Production, Preview, Development

vercel env add SCAN_LOG_EMAIL
# Enter: Mikevicentecs@gmail.com
# Select: Production, Preview, Development

# Deploy to production
vercel --prod
```

### 4. Test

1. Visit `https://your-app.vercel.app/scan`
2. Scan a book barcode
3. Check email for detailed log

## How to Use

1. Navigate to `/scan` on your deployed app
2. Click "Start Camera Scanner" or enter ISBN manually
3. Point camera at book barcode
4. Book data appears automatically
5. Check email for complete scan log with all captured data

## What Data is Captured

The scanner captures **everything** available about the book:
- Basic info (title, author, publisher, date)
- Physical details (pages, language, dimensions)
- Media (cover images in multiple sizes)
- Ratings and reviews
- Categories, genres, subjects
- Sales information
- Access information
- Full JSON data from all sources

All of this is sent in the email log for your review.

## Testing Locally

```bash
cd frontend
npm install
npm run dev
```

Visit `http://localhost:3000/scan`

**Note**: Camera access requires HTTPS, so local testing may be limited. Full functionality works on Vercel deployment.

## Environment Variables

Required environment variables (set via `vercel env add`):

- `AWS_ACCESS_KEY_ID` - AWS IAM access key
- `AWS_SECRET_ACCESS_KEY` - AWS IAM secret key
- `AWS_REGION` - AWS region (e.g., `us-east-1`)
- `AWS_SES_FROM_EMAIL` - Verified sender email in SES
- `SCAN_LOG_EMAIL` - Email to send logs to

## View Environment Variables

```bash
vercel env ls
```

## View Logs

```bash
vercel logs
```

## Troubleshooting

- **Camera not working**: Ensure HTTPS (required for camera)
- **Email not sending**: Check AWS SES credentials and verification
- **Book not found**: Try manual ISBN entry, check email for details
- **Build errors**: Run `npm install` in frontend directory

See `SCAN_APP_DEPLOYMENT.md` for detailed troubleshooting.

## Quick CLI Reference

```bash
# Deploy
vercel --prod

# View logs
vercel logs

# List env vars
vercel env ls

# Add env var
vercel env add VARIABLE_NAME

# Remove env var
vercel env rm VARIABLE_NAME
```

## Next Steps

1. Deploy to Vercel
2. Test with real books
3. Review email logs to see captured data
4. Request AWS SES production access if needed
5. Customize as needed

---

**Ready to scan!** 📚📷
