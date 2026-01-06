# 🌐 Domain Setup: ilbooks.com → Vercel

## Overview
This guide will help you connect your custom domain `ilbooks.com` to your Vercel deployment.

---

## Step 1: Add Domain in Vercel Dashboard

### Option A: Via Vercel Dashboard (Recommended)

1. **Go to your Vercel project:**
   - Visit: https://vercel.com/dashboard
   - Click on your **frontend** project (or the project name you used)

2. **Navigate to Domain Settings:**
   - Click **Settings** in the top navigation
   - Click **Domains** in the left sidebar

3. **Add your domain:**
   - In the "Domains" section, enter: `ilbooks.com`
   - Click **Add** or **Add Domain**

4. **Vercel will show you DNS records:**
   - You'll see something like:
     ```
     Type: A
     Name: @
     Value: 76.76.21.21
     
     Type: CNAME
     Name: www
     Value: cname.vercel-dns.com
     ```
   - **Copy these values** - you'll need them for your domain provider

### Option B: Via Vercel CLI

```bash
cd frontend
vercel domains add ilbooks.com
```

This will also show you the DNS records needed.

---

## Step 2: Configure DNS at Your Domain Provider

You need to add DNS records at your domain provider (GoDaddy, Namecheap, Google Domains, Cloudflare, etc.).

### DNS Records to Add:

#### For Root Domain (ilbooks.com):

**Record 1: A Record**
```
Type: A
Name: @ (or leave blank, or use "ilbooks.com")
Value: 76.76.21.21
TTL: 3600 (or Auto)
```

**Record 2: CNAME Record (for www)**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
TTL: 3600 (or Auto)
```

### ⚠️ Important Notes:

1. **Vercel's IP addresses may change** - Check your Vercel dashboard for the current values
2. **Some providers use different formats:**
   - For root domain: Use `@` or leave blank
   - For subdomain: Use `www` (without the domain name)
3. **TTL (Time To Live):** Use 3600 seconds (1 hour) or Auto
4. **Propagation:** DNS changes can take 24-48 hours, but usually work within 1-2 hours

---

## Step 3: Provider-Specific Instructions

### GoDaddy

1. Log in to GoDaddy
2. Go to **My Products** → **DNS** (or **Domain Settings**)
3. Scroll to **DNS Records**
4. Click **Add** to create new records:

   **A Record:**
   - Type: `A`
   - Name: `@`
   - Value: `76.76.21.21` (use value from Vercel)
   - TTL: `600 seconds` (or 1 hour)

   **CNAME Record:**
   - Type: `CNAME`
   - Name: `www`
   - Value: `cname.vercel-dns.com` (use value from Vercel)
   - TTL: `600 seconds` (or 1 hour)

5. Click **Save**

### Namecheap

1. Log in to Namecheap
2. Go to **Domain List** → Click **Manage** next to ilbooks.com
3. Go to **Advanced DNS** tab
4. Click **Add New Record**:

   **A Record:**
   - Type: `A Record`
   - Host: `@`
   - Value: `76.76.21.21` (use value from Vercel)
   - TTL: `Automatic`

   **CNAME Record:**
   - Type: `CNAME Record`
   - Host: `www`
   - Value: `cname.vercel-dns.com` (use value from Vercel)
   - TTL: `Automatic`

5. Click the checkmark to save

### Cloudflare

1. Log in to Cloudflare
2. Select your domain `ilbooks.com`
3. Go to **DNS** → **Records**
4. Click **Add record**:

   **A Record:**
   - Type: `A`
   - Name: `@` (or `ilbooks.com`)
   - IPv4 address: `76.76.21.21` (use value from Vercel)
   - Proxy status: **DNS only** (gray cloud) - Important!
   - TTL: `Auto`

   **CNAME Record:**
   - Type: `CNAME`
   - Name: `www`
   - Target: `cname.vercel-dns.com` (use value from Vercel)
   - Proxy status: **DNS only** (gray cloud) - Important!
   - TTL: `Auto`

5. Click **Save**

**⚠️ Cloudflare Note:** Make sure the proxy is **OFF** (gray cloud) for DNS records pointing to Vercel. Vercel handles SSL/HTTPS.

### Google Domains

1. Log in to Google Domains
2. Click on `ilbooks.com`
3. Go to **DNS** tab
4. Scroll to **Custom resource records**
5. Add records:

   **A Record:**
   - Name: `@`
   - Type: `A`
   - Data: `76.76.21.21` (use value from Vercel)
   - TTL: `3600`

   **CNAME Record:**
   - Name: `www`
   - Type: `CNAME`
   - Data: `cname.vercel-dns.com` (use value from Vercel)
   - TTL: `3600`

6. Click **Save**

---

## Step 4: Verify Domain in Vercel

1. **Wait 5-10 minutes** after adding DNS records
2. Go back to Vercel Dashboard → Settings → Domains
3. You should see:
   - ✅ Green checkmark next to `ilbooks.com`
   - Status: "Valid Configuration"

If you see an error:
- Double-check DNS records match exactly what Vercel provided
- Wait longer (DNS propagation can take time)
- Use a DNS checker tool: https://dnschecker.org

---

## Step 5: SSL Certificate (Automatic)

Vercel automatically provisions SSL certificates for custom domains. This usually happens within a few minutes after DNS is configured.

You'll see:
- ✅ SSL certificate status in Vercel dashboard
- 🔒 HTTPS enabled automatically

---

## Step 6: Update Environment Variables

After the domain is live, update your environment variables in Vercel:

1. Go to **Settings** → **Environment Variables**
2. Update or add:
   ```
   NEXT_PUBLIC_SITE_URL=https://ilbooks.com
   ```
3. **Redeploy** your project (or wait for next deployment)

---

## Step 7: Test Your Domain

1. **Wait 1-2 hours** for DNS propagation
2. Visit: `https://ilbooks.com`
3. Visit: `https://www.ilbooks.com` (should redirect to ilbooks.com)

Both should show your bookstore website!

---

## Troubleshooting

### Domain not working after 24 hours?

1. **Check DNS propagation:**
   - Use: https://dnschecker.org
   - Enter: `ilbooks.com`
   - Check if A record points to Vercel's IP

2. **Verify DNS records:**
   - Make sure records match exactly what Vercel provided
   - Check for typos in values

3. **Check Vercel dashboard:**
   - Go to Settings → Domains
   - Look for error messages
   - Check SSL certificate status

4. **Clear DNS cache:**
   ```bash
   # macOS/Linux
   sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
   
   # Or use Google's DNS: 8.8.8.8
   ```

### Common Issues

**Issue: "Domain not configured"**
- Solution: Make sure DNS records are added correctly at your provider

**Issue: "SSL certificate pending"**
- Solution: Wait 10-15 minutes, Vercel provisions SSL automatically

**Issue: "www not redirecting"**
- Solution: Vercel automatically redirects www to root domain, but verify CNAME record is correct

---

## Quick Checklist

- [ ] Added domain in Vercel Dashboard
- [ ] Copied DNS records from Vercel
- [ ] Added A record at domain provider (root domain)
- [ ] Added CNAME record at domain provider (www)
- [ ] Waited for DNS propagation (1-2 hours)
- [ ] Verified domain in Vercel (green checkmark)
- [ ] Updated `NEXT_PUBLIC_SITE_URL` environment variable
- [ ] Tested `https://ilbooks.com` in browser
- [ ] Tested `https://www.ilbooks.com` (should redirect)

---

## Need Help?

If you're stuck:
1. Check Vercel's domain docs: https://vercel.com/docs/concepts/projects/domains
2. Contact your domain provider's support
3. Check Vercel dashboard for specific error messages

**Your domain will be live once DNS propagates!** 🎉

