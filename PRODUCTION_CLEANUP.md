# Production Cleanup Guide

Files to keep for production deployment on Vercel:

## ✅ Keep These Files

```
.gitignore              # Git exclusions
.npmrc                  # npm configuration
package.json            # Root workspace config
package-lock.json       # Dependency lock

backend/
  ├── api/              # API endpoints
  ├── lib/              # Utilities
  ├── dev.ts            # Entry point
  ├── package.json
  ├── tsconfig.json
  ├── vercel.json       # Vercel config
  └── .env.local        # (Not in git, set in Vercel)

frontend/
  ├── src/              # React source
  ├── public/           # Static assets
  ├── index.html
  ├── package.json
  ├── tsconfig.json
  ├── vite.config.ts
  ├── postcss.config.js
  ├── tailwind.config.js
  └── .env.production   # (Not in git, set in Vercel)

database/
  └── schema.sql        # Database schema

Documentation/
  ├── README.md                    # Production overview
  ├── PRODUCTION_SETUP.md          # Environment & security setup
  ├── VERCEL_DEPLOYMENT.md         # Deployment walkthrough
  ├── API_DOCUMENTATION.md         # API reference
  └── DEPLOYMENT_CHECKLIST.md      # Pre-deployment verification
```

## ❌ Remove These Files

Screenshots and development files (automatically excluded via `.gitignore`):

```
*.PNG                   # Development screenshots
*.png
*.jpg
*.jpeg

LOCAL_SETUP.md          # Local development only
SETUP.md               # Duplicate of PRODUCTION_SETUP.md
RESPONSIVE_UI_CHANGES.md  # Development notes
CONTRIBUTING.md        # Not needed for deployment
QUICKSTART.md          # Merged into README.md
PROJECT_SUMMARY.md     # Internal documentation
```

## Automated Cleanup

The `.gitignore` file has been updated to exclude:
- Screenshot files (`*.PNG`, `*.png`, `*.jpg`, `*.jpeg`)
- Development documentation files
- Environment files (`.env.local`)
- Build artifacts

These files won't be committed to Git but can exist locally.

## Manual Cleanup (Optional)

To clean up before first production commit:

```bash
# Remove screenshot files
rm -f *.PNG *.png *.jpg *.jpeg

# Remove development-only docs
rm -f LOCAL_SETUP.md SETUP.md RESPONSIVE_UI_CHANGES.md CONTRIBUTING.md QUICKSTART.md PROJECT_SUMMARY.md

# Verify structure
git status
```

## Vercel Deployment Files

✅ **Keep in root:**
- `package.json` (workspace config)
- `package-lock.json`

✅ **Keep in backend:**
- `vercel.json` (serverless functions config)
- `dev.ts` (entry point)

✅ **Keep in frontend:**
- `vite.config.ts`
- `package.json`
- `postcss.config.js`
- `tailwind.config.js`

## Environment Configuration

### NOT in Git (Set in Vercel Dashboard)

**Backend Environment Variables:**
```
SUPABASE_URL
SUPABASE_ANON_KEY
JWT_SECRET
ADMIN_EMAIL
ADMIN_PASSWORD_HASH
NODE_ENV
```

**Frontend Environment Variables:**
```
VITE_API_URL
```

### File Locations:
- Backend `.env.local` → Ignored by `.gitignore`
- Frontend `.env.production` → Ignored by `.gitignore`

## Pre-Deployment Checklist

- [ ] Removed all screenshot files
- [ ] Removed development documentation
- [ ] Updated `.gitignore` (already done)
- [ ] Environment variables set in Vercel dashboard
- [ ] Database schema deployed
- [ ] Admin credentials set
- [ ] Verified no `.env` files committed
- [ ] Run `npm run build` successfully
- [ ] All tests passing
- [ ] Ready for production push

## First Production Push

```bash
# Verify git status (should be clean after .gitignore)
git status

# Add and commit
git add -A
git commit -m "Production ready deployment"

# Push to repository
git push origin main
```

## Continuous Deployment

Vercel will automatically:
1. Detect pushes to main branch
2. Build frontend (Vite build)
3. Build backend (serverless functions)
4. Deploy both automatically

No manual `vercel deploy` needed after initial setup.
