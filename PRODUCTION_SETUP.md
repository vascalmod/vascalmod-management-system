# Production Setup Guide

Complete guide for preparing the License Management System for production deployment.

## Environment Configuration

### Backend Environment Variables

Create `.env.local` in the `backend/` directory:

```
# Supabase
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key_here

# JWT
JWT_SECRET=your_very_long_random_secret_key_here

# Admin Credentials (set these securely)
ADMIN_EMAIL=admin@yourdomain.com
ADMIN_PASSWORD_HASH=bcrypt_hashed_password_here

# Server
NODE_ENV=production
PORT=3001
```

### Frontend Environment Variables

Create `.env.production` in the `frontend/` directory:

```
VITE_API_URL=https://your-backend-domain.vercel.app
```

## Database Setup

1. **Create Supabase Project**
   - Go to https://supabase.com
   - Create new project
   - Wait for project initialization

2. **Deploy Schema**
   - Open Supabase SQL editor
   - Copy contents of `database/schema.sql`
   - Execute in SQL editor

3. **Create Initial Admin User**
   ```sql
   INSERT INTO admins (email, password_hash)
   VALUES ('admin@example.com', 'your_bcrypt_hash');
   ```

4. **Verify Tables**
   - licenses
   - devices
   - login_logs
   - admins

## Security Configuration

### 1. Database Security

- Enable RLS (Row Level Security) in production
- Create proper RLS policies for each table
- Use service role for backend operations
- Use anon key for client operations only

### 2. JWT Security

- Use a strong, random JWT_SECRET
- Minimum 32 characters recommended
- Rotate secret periodically

### 3. CORS Configuration

Configure CORS in backend if frontend is on different domain:
```typescript
const corsOptions = {
  origin: 'https://your-frontend-domain.com',
  credentials: true
};
```

### 4. Rate Limiting

- Enable rate limiting on all endpoints
- Configure limits based on expected traffic
- Stricter limits on auth endpoints

## Build & Deployment

### Local Build Test

```bash
# Install dependencies
npm run install-all

# Build both frontend and backend
npm run build

# Test production build locally
cd backend
npm run start
```

### Deploy to Vercel

See [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md)

## Health Checks

### Before Going Live

1. **API Health**
   ```bash
   curl https://your-backend/api/health
   ```

2. **Database Connection**
   - Login to admin panel
   - Verify dashboard loads

3. **End-to-End Flow**
   - Create test license
   - Activate license on test device
   - Verify device binding
   - Check logs display correctly

4. **Error Handling**
   - Test invalid login
   - Test expired license
   - Test device limit exceeded

## Monitoring & Maintenance

### Daily Checks
- Monitor error logs
- Check database performance
- Review login activity

### Weekly Tasks
- Review access logs
- Check for security issues
- Verify backups running

### Monthly Tasks
- Review performance metrics
- Audit user activity
- Update dependencies (if needed)

## Performance Optimization

1. **Database Indexing**
   - Indexes on frequently queried columns already created
   - Monitor query performance

2. **Caching**
   - Consider caching license validation
   - Cache device count per license

3. **API Response Times**
   - Target: < 200ms
   - Monitor in Vercel dashboard

## Backup & Recovery

1. **Database Backups**
   - Enable automated backups in Supabase
   - Set retention to at least 30 days
   - Test restore procedure monthly

2. **Deployment Backups**
   - Vercel automatically maintains deployment history
   - Keep previous deployment available for quick rollback

## Update Procedure

When updating production:

1. Test changes locally
2. Deploy backend first (if changes made)
3. Deploy frontend
4. Run health checks
5. Monitor for errors
6. Have rollback plan ready

## Troubleshooting

### Database Connection Issues
- Verify SUPABASE_URL and SUPABASE_ANON_KEY
- Check network connectivity
- Review Supabase logs

### Authentication Issues
- Verify JWT_SECRET matches between deployments
- Check token expiration settings
- Clear browser cache

### Device Binding Issues
- Verify HWID calculation matches client
- Check device limit settings
- Review database records

## Support Resources

- Vercel Docs: https://vercel.com/docs
- Supabase Docs: https://supabase.com/docs
- Node.js Docs: https://nodejs.org/docs
