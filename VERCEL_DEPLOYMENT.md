# Vercel Deployment Guide

This guide covers deploying the License Management System to Vercel.

## Prerequisites

- Vercel account (https://vercel.com)
- Supabase project with database
- Environment variables configured

## Deployment Steps

### 1. Frontend Deployment

```bash
cd frontend
vercel
```

#### Environment Variables (Frontend)
Create `.env.production` in `frontend/`:
```
VITE_API_URL=https://your-backend-domain.vercel.app
```

### 2. Backend Deployment

```bash
cd backend
vercel
```

#### Environment Variables (Backend)
Set these in Vercel dashboard under Project Settings > Environment Variables:

```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
JWT_SECRET=your_jwt_secret
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD_HASH=hashed_password
NODE_ENV=production
```

### 3. Configure Backend for Vercel

Backend is already configured with `vercel.json` in the backend directory.

### 4. Connect Frontend to Backend

Update `frontend/src/lib/api.ts`:
```typescript
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001';
```

### 5. Database Setup

Ensure Supabase tables are created:
```bash
# Run from backend directory
npm run seed  # if seed script exists
```

Or manually execute `database/schema.sql` in Supabase SQL editor.

## Vercel-Specific Configuration

### Frontend (`vite.config.ts`)
- Already configured with Vite default settings
- Build output: `dist/`

### Backend (`vercel.json`)
```json
{
  "version": 2,
  "builds": [
    {
      "src": "dev.ts",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "dev.ts"
    }
  ]
}
```

## Production Checklist

- [ ] Supabase RLS policies configured
- [ ] Environment variables set in Vercel dashboard
- [ ] Frontend `.env.production` configured
- [ ] Backend `vercel.json` in place
- [ ] Database schema deployed
- [ ] Admin credentials set
- [ ] CORS configured if needed
- [ ] Rate limiting enabled
- [ ] Error logging configured
- [ ] Database backups enabled

## Monitoring

- Monitor Vercel dashboard for deployment status
- Check Supabase dashboard for database health
- Review error logs in Vercel Functions

## Rollback

To rollback to previous deployment in Vercel:
1. Go to Vercel dashboard
2. Select the project
3. Go to Deployments
4. Click on previous deployment
5. Click "Redeploy"

## Support

For issues, check:
- Vercel documentation: https://vercel.com/docs
- Supabase documentation: https://supabase.com/docs
- Application logs in Vercel dashboard
