# Vercel Pre-Deployment Checklist

Complete this checklist before deploying to Vercel.

## Project Preparation

- [ ] Code is clean and tested locally
- [ ] All uncommitted changes are saved
- [ ] `.env.local` files are NOT committed
- [ ] `package-lock.json` is committed
- [ ] No `node_modules/` in git
- [ ] `.gitignore` excludes all temporary files

## Backend Setup

### Code
- [ ] `backend/vercel.json` exists and is configured
- [ ] `backend/dev.ts` is the entry point
- [ ] `backend/tsconfig.json` exists
- [ ] All API routes in `backend/api/` are working
- [ ] Rate limiting is enabled
- [ ] Error handling is implemented

### Package Configuration
- [ ] `backend/package.json` has correct name/version
- [ ] All dependencies are in `package.json` (not global)
- [ ] Node.js version compatible with Vercel (v14+)
- [ ] `npm run build` completes without errors
- [ ] `npm run dev` runs locally

### Environment Variables
- [ ] `SUPABASE_URL` is set
- [ ] `SUPABASE_ANON_KEY` is set
- [ ] `JWT_SECRET` is strong and random (32+ chars)
- [ ] `ADMIN_EMAIL` is configured
- [ ] `ADMIN_PASSWORD_HASH` is set
- [ ] `NODE_ENV` defaults to `production`

## Frontend Setup

### Code
- [ ] `frontend/vite.config.ts` is configured correctly
- [ ] `frontend/tsconfig.json` exists
- [ ] All routes in `frontend/src/App.tsx` are defined
- [ ] `frontend/src/lib/api.ts` uses `VITE_API_URL`
- [ ] All imports use relative paths
- [ ] No hardcoded API URLs (except environment variables)

### Package Configuration
- [ ] `frontend/package.json` has correct name/version
- [ ] All dependencies are in `package.json`
- [ ] `npm run build` creates `dist/` folder
- [ ] `npm run preview` runs locally
- [ ] No build errors or warnings

### Environment Variables
- [ ] `VITE_API_URL` points to backend deployment
- [ ] `.env.production` created (not in git)

### Assets
- [ ] `public/` folder exists
- [ ] `public/index.html` is correct
- [ ] No broken image/asset references

## Database Setup

### Supabase
- [ ] Supabase project is created
- [ ] `database/schema.sql` is executed
- [ ] All tables exist:
  - [ ] `licenses`
  - [ ] `devices`
  - [ ] `login_logs`
  - [ ] `admins`
- [ ] Columns match backend queries
- [ ] Indexes are created for performance
- [ ] RLS policies are reviewed (consider enabling in production)

### Initial Data
- [ ] Admin user is created in `admins` table
- [ ] Test license is created
- [ ] Test data is clean (no garbage data)

## Security Review

- [ ] No secrets in code files
- [ ] No API keys in frontend
- [ ] JWT_SECRET is strong and unique
- [ ] CORS configuration reviewed
- [ ] Rate limiting is configured
- [ ] Input validation is implemented
- [ ] Error messages don't expose internals
- [ ] Database connections are encrypted

## Vercel Configuration

### Account Setup
- [ ] Vercel account created
- [ ] GitHub repository connected (if using GitHub integration)
- [ ] Vercel CLI installed (optional, for testing)

### Create Projects
- [ ] Backend project created in Vercel
- [ ] Frontend project created in Vercel
- [ ] Environment variables set for both

### Backend Project Settings
1. Go to project settings
2. Environment Variables:
   - Add `SUPABASE_URL`
   - Add `SUPABASE_ANON_KEY`
   - Add `JWT_SECRET`
   - Add `ADMIN_EMAIL`
   - Add `ADMIN_PASSWORD_HASH`
   - Add `NODE_ENV=production`
3. Framework: `Other` (serverless)
4. Build command: Leave empty (uses package.json)

### Frontend Project Settings
1. Go to project settings
2. Framework: `Vite`
3. Build command: `npm run build`
4. Output directory: `dist`
5. Environment Variables:
   - Add `VITE_API_URL=https://your-backend.vercel.app`

## Testing Checklist

### Local Testing
- [ ] Backend starts: `npm run dev` (backend folder)
- [ ] Frontend starts: `npm run dev` (frontend folder)
- [ ] Login page loads without errors
- [ ] API calls work and return correct data
- [ ] Admin login functionality works
- [ ] Dashboard displays data
- [ ] License management works
- [ ] Logs page displays data

### Deployment Testing
- [ ] Backend deployment successful (check Vercel)
- [ ] Frontend deployment successful (check Vercel)
- [ ] Frontend connects to deployed backend
- [ ] Login works on deployed frontend
- [ ] Dashboard loads with real data
- [ ] All pages are accessible
- [ ] No console errors or warnings
- [ ] API calls complete successfully

### API Testing
- [ ] `GET /api/health` responds
- [ ] `POST /api/admin-login` returns JWT
- [ ] `GET /api/licenses` returns license list
- [ ] `POST /api/login` activates license
- [ ] `GET /api/logs` returns login logs
- [ ] `GET /api/stats` returns dashboard stats

## Performance Check

- [ ] Frontend load time < 3 seconds
- [ ] API response time < 500ms
- [ ] No console errors on production
- [ ] No browser warnings
- [ ] Images are optimized
- [ ] Code is minified in production

## Documentation

- [ ] README.md updated with live links
- [ ] PRODUCTION_SETUP.md is complete
- [ ] VERCEL_DEPLOYMENT.md is accurate
- [ ] API_DOCUMENTATION.md is current
- [ ] All team members have access to docs

## Final Steps

1. **Create Git Tag** (after first successful deployment)
   ```bash
   git tag -a v1.0.0 -m "First production deployment"
   git push origin v1.0.0
   ```

2. **Setup Monitoring**
   - [ ] Vercel analytics enabled
   - [ ] Error notifications configured
   - [ ] Uptime monitoring setup (optional)

3. **Backup Strategy**
   - [ ] Database backups enabled in Supabase
   - [ ] Backup retention set to 30+ days
   - [ ] Test restore procedure

4. **Team Communication**
   - [ ] Share deployment URLs with team
   - [ ] Share admin login credentials securely
   - [ ] Document any custom configurations

## Rollback Plan

In case of issues:

1. **Quick Rollback** (Vercel)
   - Go to Vercel dashboard
   - Select project
   - Click Deployments
   - Select previous stable deployment
   - Click "Redeploy"

2. **Database Rollback** (Supabase)
   - Use database backup from Supabase
   - Restore to previous snapshot

3. **Code Rollback** (Git)
   ```bash
   git revert <commit-hash>
   git push origin main
   # Vercel will auto-deploy
   ```

## Sign Off

- [ ] Project Lead Review
- [ ] Security Review Complete
- [ ] Ready for Production

**Approved by:** ________________ **Date:** ________________

---

For issues during deployment, see [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md)
