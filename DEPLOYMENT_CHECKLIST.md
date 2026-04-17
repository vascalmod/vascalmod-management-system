# Deployment Checklist

Complete this checklist before deploying to production.

## Pre-Deployment Planning

- [ ] Read [README.md](README.md) and understand architecture
- [ ] Read [API_DOCUMENTATION.md](API_DOCUMENTATION.md)
- [ ] Review [SETUP.md](SETUP.md) for all configuration
- [ ] Have Supabase and Vercel accounts ready
- [ ] Have a domain name (optional but recommended)

## Supabase Setup

- [ ] Create new Supabase project
- [ ] Copy Project URL to secure location
- [ ] Copy Service Role key to secure location
- [ ] Run `database/schema.sql` in SQL Editor
- [ ] Verify all tables created:
  - [ ] licenses
  - [ ] devices
  - [ ] login_logs
  - [ ] admins
- [ ] Create admin user via Auth
- [ ] Insert admin user into admins table
- [ ] Test admin login credentials locally
- [ ] Enable RLS on all tables (schema.sql does this)
- [ ] Set up database backups
- [ ] Test Supabase connection from localhost

## Backend Deployment (Vercel)

- [ ] Install Vercel CLI: `npm install -g vercel`
- [ ] Login to Vercel: `vercel login`
- [ ] Prepare backend environment variables:
  - [ ] SUPABASE_URL
  - [ ] SUPABASE_SERVICE_KEY
  - [ ] JWT_SECRET (unique, strong, 32+ chars)
- [ ] Test backend locally: `npm run dev`
- [ ] Deploy: `cd backend && vercel deploy --prod`
- [ ] Add environment variables in Vercel dashboard:
  - Go to Settings → Environment Variables
  - Add SUPABASE_URL
  - Add SUPABASE_SERVICE_KEY
  - Add JWT_SECRET
- [ ] Redeploy after adding variables
- [ ] Copy deployment URL (e.g., https://api-xyz.vercel.app)
- [ ] Test health endpoint: `curl https://api-xyz.vercel.app/api/health`
- [ ] Test login endpoint with valid license
- [ ] Enable rate limiting is working

## Frontend Deployment (Vercel)

- [ ] Update `frontend/.env.local`:
  ```
  VITE_API_URL=https://api-xyz.vercel.app
  ```
- [ ] Build locally: `npm run build`
- [ ] Test locally: `npm run preview`
- [ ] Deploy: `cd frontend && vercel deploy --prod`
- [ ] Test login page loads
- [ ] Test admin login works
- [ ] Test dashboard displays
- [ ] Test create license form
- [ ] Test view logs page
- [ ] Test logout button

## Security Review

- [ ] JWT_SECRET is unique and strong (32+ chars)
- [ ] No credentials in `.env.local` files (use `.env.example`)
- [ ] SUPABASE_SERVICE_KEY never exposed to frontend
- [ ] RLS policies enabled on all tables
- [ ] Rate limiting activated on /api/login
- [ ] HTTPS enabled on both frontend and backend (Vercel default)
- [ ] CORS configured if needed
- [ ] Audit logging for sensitive operations
- [ ] Admin user password is strong
- [ ] No test/debug code in production

## Testing

### License Activation Flow
```bash
# 1. Create license in dashboard
# 2. Copy license key
# 3. Test activation
curl -X POST https://api-xyz.vercel.app/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "license_key": "LIC-...",
    "hwid": "test-hwid"
  }'

# Should return: {"success": true, "token": "...", "expires_at": "..."}
```

### Admin Functions
- [ ] Admin can login
- [ ] Admin can view all licenses
- [ ] Admin can create new license
- [ ] Admin can revoke license
- [ ] Admin can view login logs
- [ ] Admin can filter logs by status
- [ ] Admin can filter logs by country
- [ ] Logout works correctly

### Error Handling
- [ ] Invalid license key shows error
- [ ] Expired license shows error
- [ ] Device limit exceeded shows error
- [ ] Strict mode violation shows error
- [ ] Invalid credentials on admin login shows error
- [ ] Unauthorized access (no token) returns 401
- [ ] Rate limiting returns 429

### Geolocation
- [ ] Logs show geolocation data
- [ ] Country filtering works
- [ ] Location data is accurate

## Monitoring Setup

- [ ] Enable Vercel Analytics
- [ ] Set up error logging/alerts
- [ ] Monitor database growth
- [ ] Set up backup alerts
- [ ] Monitor API response times
- [ ] Track failed login attempts

## Performance Optimization

- [ ] Database indexes created (schema.sql handles this)
- [ ] Frontend build is optimized (Vite does this)
- [ ] API response times acceptable
- [ ] No N+1 queries
- [ ] Pagination works for large datasets

## Documentation

- [ ] Update README with deployment URLs
- [ ] Document custom domain setup (if used)
- [ ] Document admin user management process
- [ ] Document backup/restore procedures
- [ ] Document monitoring procedures
- [ ] Create runbook for common issues

## Post-Deployment

- [ ] Verify all pages accessible
- [ ] Test on multiple browsers
- [ ] Test on mobile devices
- [ ] Monitor error logs first 24 hours
- [ ] Monitor database usage
- [ ] Check Supabase audit logs
- [ ] Announce system to users
- [ ] Create support documentation

## Maintenance Plan

- [ ] Set up weekly database backups
- [ ] Plan monthly security reviews
- [ ] Plan quarterly dependency updates
- [ ] Document license expiration policy
- [ ] Set up alerts for:
  - API errors
  - Database growth
  - Failed logins spike
  - Rate limiting hits
  - Backup failures

## Disaster Recovery

- [ ] Document backup/restore procedure
- [ ] Test backup restoration
- [ ] Document failover procedure
- [ ] Have emergency contact list
- [ ] Document data retention policy
- [ ] Plan for data export requirements

## Compliance & Legal

- [ ] GDPR compliance review (if applicable)
- [ ] Privacy policy written
- [ ] Terms of service written
- [ ] Data retention policy documented
- [ ] License agreement prepared
- [ ] EULA prepared for clients

## Launch Communication

- [ ] Prepare launch announcement
- [ ] Create user documentation
- [ ] Create admin guide
- [ ] Prepare support email template
- [ ] Set up email notifications
- [ ] Schedule launch time

## Sign-Off

- [ ] Backend engineer approves
- [ ] Frontend engineer approves
- [ ] DevOps/Infrastructure approves
- [ ] Security review completed
- [ ] Legal/Compliance approves
- [ ] Product manager approves
- [ ] Ready for public launch

---

## Rollback Plan

If issues occur post-deployment:

1. **Backend**: `vercel rollback` in backend directory
2. **Frontend**: `vercel rollback` in frontend directory
3. **Database**: Restore from Supabase backup (Settings → Backups)
4. **Communication**: Notify users of incident

## Emergency Contacts

- Supabase Support: https://supabase.com/support
- Vercel Support: https://vercel.com/support
- Your team: [Add contact info]

---

**Estimated Time**: 2-3 hours for complete deployment and testing

**Good luck! 🚀**
