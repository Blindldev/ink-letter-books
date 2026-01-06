# Book Scanner App - Deployment Guide

This guide will help you deploy the barcode scanning web app to Vercel so you can test it on your phone.

## Features

- 📷 **Barcode Scanning**: Use your phone's camera to scan ISBN barcodes
- 📚 **Comprehensive Book Data**: Fetches data from Google Books and Open Library
- 📧 **Email Logging**: Automatically emails scan results and logs to Mikevicentecs@gmail.com via AWS SES
- 🔍 **Manual ISBN Entry**: Option to manually enter ISBN if scanning fails
- 📱 **Mobile Optimized**: Works great on phones and tablets

## Prerequisites

1. A Vercel account (free tier works)
2. An AWS account with SES configured
3. Node.js installed locally (for testing)

## Step 1: Set Up AWS SES (Email Service)

1. Go to [AWS Console](https://console.aws.amazon.com) and sign in
2. Navigate to **Simple Email Service (SES)**
3. **Verify your email address** (Mikevicentecs@gmail.com):
   - Go to **Verified identities** → **Create identity**
   - Choose **Email address**
   - Enter `Mikevicentecs@gmail.com`
   - Check your email and click the verification link
4. **Create IAM user for SES**:
   - Go to **IAM** → **Users** → **Create user**
   - Name: `book-scanner-ses`
   - Attach policy: `AmazonSESFullAccess` (or create custom policy with only SendEmail permission)
   - Create user and **save the Access Key ID and Secret Access Key**

**Note**: If you're in SES sandbox mode, you can only send to verified email addresses. To send to any email, request production access in SES.

## Step 2: Install Dependencies

```bash
cd frontend
npm install
```

This will install `html5-qrcode` and `@aws-sdk/client-ses` which are needed for barcode scanning and email sending.

## Step 3: Deploy to Vercel via CLI

1. **Install Vercel CLI** (if not already installed):
   ```bash
   npm i -g vercel
   ```

2. **Navigate to frontend directory**:
   ```bash
   cd frontend
   ```

3. **Login to Vercel**:
   ```bash
   vercel login
   ```

4. **Link your project** (first time only):
   ```bash
   vercel link
   ```
   - Follow prompts to select/create project
   - Choose your organization
   - Confirm settings

5. **Set environment variables via CLI**:
   ```bash
   vercel env add AWS_ACCESS_KEY_ID
   # Paste your AWS Access Key ID when prompted
   # Select: Production, Preview, Development (all environments)
   
   vercel env add AWS_SECRET_ACCESS_KEY
   # Paste your AWS Secret Access Key when prompted
   # Select: Production, Preview, Development (all environments)
   
   vercel env add AWS_REGION
   # Enter: us-east-1 (or your preferred AWS region)
   # Select: Production, Preview, Development (all environments)
   
   vercel env add AWS_SES_FROM_EMAIL
   # Enter: Mikevicentecs@gmail.com (or your verified SES email)
   # Select: Production, Preview, Development (all environments)
   
   vercel env add SCAN_LOG_EMAIL
   # Enter: Mikevicentecs@gmail.com
   # Select: Production, Preview, Development (all environments)
   ```

6. **Deploy to production**:
   ```bash
   vercel --prod
   ```

## Step 4: Test the App

1. Once deployed, visit your Vercel URL (e.g., `https://your-app.vercel.app`)
2. Navigate to `/scan` (e.g., `https://your-app.vercel.app/scan`)
3. On your phone:
   - Grant camera permissions when prompted
   - Point the camera at a book's barcode
   - The app will automatically detect the ISBN and fetch book data
4. Check your email (Mikevicentecs@gmail.com) for the detailed scan log

## How It Works

### Scanning Process

1. **User scans barcode** → ISBN is detected
2. **API fetches data** from multiple sources:
   - Google Books API
   - Open Library API
3. **Data is merged** to create comprehensive book information
4. **Email is sent via AWS SES** with:
   - All captured book data (JSON format)
   - API call logs (success/failure, duration)
   - Any errors or warnings
   - User agent and IP address

### Book Data Captured

The scanner captures comprehensive book information including:

- Basic Info: Title, Authors, Publisher, Published Date
- Physical Details: Page Count, Language, Dimensions
- Metadata: ISBN, Categories, Genres, Subjects
- Media: Cover Images (multiple sizes)
- Ratings: Average Rating, Ratings Count
- Links: Preview Links, Info Links, Buy Links
- Additional: Description, Table of Contents, Classifications
- Sales Info: List Price, Retail Price, Availability
- Access Info: Preview availability, eBook availability

### Email Log Format

Each scan sends an email with:
- **HTML formatted** summary with book cover and key details
- **Plain text** version for easy reading
- **Full JSON data** for complete information
- **Error logs** if any issues occurred
- **API call summary** showing which sources succeeded/failed

## Troubleshooting

### Camera Not Working

- Ensure you're using HTTPS (required for camera access)
- Check browser permissions for camera access
- Try a different browser (Chrome/Safari work best)
- On iOS, ensure you're using Safari (not Chrome)

### Email Not Sending

- Verify AWS credentials are set correctly in Vercel
- Check AWS SES console for bounces/complaints
- Ensure email address is verified in SES (if in sandbox mode)
- Check Vercel function logs: `vercel logs`
- Verify IAM user has SES permissions

### Book Not Found

- Try scanning the barcode again (sometimes lighting affects detection)
- Manually enter the ISBN to verify it's correct
- Some books may not be in the databases
- Check the email log for detailed error information

### Build Errors

- Ensure all dependencies are installed: `npm install`
- Check that `html5-qrcode` and `@aws-sdk/client-ses` are in package.json
- Verify Node.js version (18+ recommended)

### AWS SES Issues

- **Sandbox Mode**: You can only send to verified email addresses
- **Production Access**: Request production access in SES to send to any email
- **Bounce Rate**: Keep bounce rate below 5% to avoid suspension
- **Rate Limits**: SES has rate limits (check your account limits)

## Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `AWS_ACCESS_KEY_ID` | AWS IAM user access key | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM user secret key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION` | AWS region for SES | `us-east-1` |
| `AWS_SES_FROM_EMAIL` | Verified sender email in SES | `Mikevicentecs@gmail.com` |
| `SCAN_LOG_EMAIL` | Email address to send logs to | `Mikevicentecs@gmail.com` |

## Viewing Logs

View Vercel function logs via CLI:
```bash
vercel logs
```

Or view in Vercel dashboard: Project → Functions → View logs

## API Endpoints

### POST `/api/scan`

Scans an ISBN and returns comprehensive book data.

**Request:**
```json
{
  "isbn": "9780143127741"
}
```

**Response:**
```json
{
  "success": true,
  "bookData": {
    "isbn": "9780143127741",
    "title": "The Great Gatsby",
    "authors": ["F. Scott Fitzgerald"],
    // ... comprehensive book data
  },
  "log": {
    "errors": [],
    "warnings": [],
    "apiCalls": [...]
  }
}
```

## Security Notes

- The app uses HTTPS (required by Vercel) for camera access
- AWS credentials are stored as environment variables (never in code)
- Email logs include IP address and user agent for security tracking
- No personal data is stored, only scan logs are emailed
- IAM user should have minimal permissions (only SES SendEmail)

## Cost Estimates

- **Vercel**: Free tier includes 100GB bandwidth/month (plenty for testing)
- **AWS SES**: Free tier includes 62,000 emails/month (2,000+ scans/day)
- **Google Books API**: Free (no API key needed)
- **Open Library API**: Free (no API key needed)

## Quick CLI Commands Reference

```bash
# Install dependencies
cd frontend && npm install

# Login to Vercel
vercel login

# Link project (first time)
vercel link

# Add environment variable
vercel env add VARIABLE_NAME

# Deploy to preview
vercel

# Deploy to production
vercel --prod

# View logs
vercel logs

# List environment variables
vercel env ls

# Remove environment variable
vercel env rm VARIABLE_NAME
```

## Next Steps

1. Test the scanner with various books
2. Check email logs to see what data is captured
3. Customize the email template if needed (in `route.ts`)
4. Request AWS SES production access if needed
5. Add more data sources if desired (Amazon API, etc.)

## Support

If you encounter issues:
1. Check Vercel function logs: `vercel logs`
2. Check AWS SES console for delivery status
3. Review the email logs for detailed error information
4. Ensure all environment variables are set correctly: `vercel env ls`

---

**Ready to scan!** 📚📷
