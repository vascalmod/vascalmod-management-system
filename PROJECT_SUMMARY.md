# License Management System - Project Summary

## 🎯 What's Included

A **production-ready, fully-featured License Management System** built with:
- **Frontend**: React 18 + Vite + TypeScript + Tailwind CSS
- **Backend**: Node.js serverless (Vercel) + TypeScript
- **Database**: Supabase PostgreSQL
- **Auth**: JWT + Supabase Auth
- **Logging**: Geolocation-aware login analytics

## 📁 Project Structure

```
license-management-system/
├── backend/                          # Node.js serverless APIs
│   ├── api/
│   │   ├── login.ts                 # Client license activation
│   │   ├── admin-login.ts           # Admin authentication
│   │   ├── licenses.ts              # License CRUD operations
│   │   ├── logs.ts                  # Login analytics queries
│   │   ├── stats.ts                 # Dashboard statistics
│   │   └── health.ts                # Health check endpoint
│   ├── lib/
│   │   ├── auth.ts                  # JWT verification/generation
│   │   ├── rateLimit.ts             # Rate limiting middleware
│   │   └── utils.ts                 # Utility functions
│   ├── package.json
│   ├── tsconfig.json
│   ├── vercel.json
│   └── .env.example
│
├── frontend/                         # React admin dashboard
│   ├── src/
│   │   ├── pages/
│   │   │   ├── LoginPage.tsx        # Admin login interface
│   │   │   ├── DashboardPage.tsx    # Dashboard with stats
│   │   │   ├── LicensesPage.tsx     # License management UI
│   │   │   └── LogsPage.tsx         # Login analytics viewer
│   │   ├── components/
│   │   │   └── ProtectedRoute.tsx   # Route authentication guard
│   │   ├── store/
│   │   │   └── auth.ts              # Zustand auth store
│   │   ├── lib/
│   │   │   └── api.ts               # Axios API client
│   │   ├── App.tsx                  # Main app component
│   │   ├── main.tsx                 # Entry point
│   │   └── index.css                # Tailwind styles
│   ├── public/
│   │   └── index.html
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   ├── tailwind.config.js
│   └── .env.example
│
├── database/
│   └── schema.sql                   # PostgreSQL schema
│
├── README.md                        # Full project overview
├── SETUP.md                         # Detailed setup guide
├── QUICKSTART.md                    # 10-minute quick start
├── API_DOCUMENTATION.md             # Complete API reference
├── CONTRIBUTING.md                  # Development guidelines
├── .gitignore
└── package.json                     # Root workspace config

```

## ✨ Features Implemented

### Backend API (Vercel Serverless)

✅ **POST /api/login** - Client license activation
- License key validation
- HWID normalization (lowercase, no special chars)
- Device activation tracking
- Strict mode enforcement (lock to first device)
- Max devices limit
- JWT token generation
- Geolocation logging (ipapi.co)
- Automatic expiration checking
- 5 req/15min rate limiting

✅ **POST /api/admin-login** - Admin authentication
- Supabase Auth integration
- JWT token generation
- Admin verification

✅ **GET /api/licenses** - List all licenses
- Admin only (JWT protected)
- Device count per license
- Status indicators

✅ **POST /api/licenses?action=create** - Create new license
- Auto-generate unique keys (LIC-...)
- Plan-based expiration (1/3/7/30 days)
- Configurable max devices
- Strict mode toggle

✅ **POST /api/licenses?action=revoke** - Revoke license
- Admin only
- Prevents future activations

✅ **GET /api/logs** - Query login logs
- Admin only
- Filter by status/country
- Pagination (limit/offset)
- Geolocation data included
- Timestamp ordering

✅ **GET /api/stats** - Dashboard statistics
- Total/active/expired licenses
- Device activation count
- Login success rate
- Failed login tracking

✅ **GET /api/health** - Health check
- Supabase connection test
- API status verification

### Frontend Dashboard (React)

✅ **Admin Login Page**
- Email/password authentication
- Error messages
- Loading states
- Responsive design

✅ **Dashboard Page**
- 4 key statistics cards
- Recent activity table
- Real-time data loading

✅ **Licenses Page**
- List all licenses with details
- Status indicators (Active/Expired/Revoked)
- Device count display
- Revoke button
- Create License modal
- Plan selection (Starter/Standard/Premium/Enterprise)
- Max devices configuration
- Strict mode toggle
- Auto-copy license keys

✅ **Logs Page**
- Login activity viewer
- Filter by status (Success/Failed)
- Filter by country
- Location display (city, country, ISP)
- IP address logging
- Pagination controls
- Configurable page size
- Timestamp formatting

✅ **Responsive UI**
- Collapsible sidebar navigation
- Tailwind CSS styling
- Dark theme (slate colors)
- Mobile-friendly layout
- Loading indicators
- Error messages

### Database (Supabase PostgreSQL)

✅ **licenses table**
- UUID primary key
- Unique license key
- Plan type
- Max device limit
- Strict mode flag
- Revocation tracking
- Automatic timestamps
- Indexes on key, expires_at, revoked

✅ **devices table**
- Track activated devices per license
- Hardware ID (normalized)
- Activation timestamp
- Last seen tracking
- Foreign key to licenses

✅ **login_logs table**
- License key reference
- HWID tracking
- IP address logging
- Status tracking (success/failed)
- JSON location data
- User agent logging
- Timestamp with index
- Queryable by status/country

✅ **admins table**
- User ID (FK to auth.users)
- Email tracking
- Creation timestamp

✅ **Row Level Security**
- Service role access enforced
- Policies prevent direct auth user access

### Security Features

✅ **JWT Authentication**
- 24-hour token expiration
- Admin-only endpoint protection
- Token verification on all protected routes

✅ **Rate Limiting**
- 5 requests per 15 minutes on login endpoint
- Per IP address tracking
- Retry-After headers

✅ **HWID Normalization**
- Removes special characters
- Lowercase conversion
- Prevents device spoofing

✅ **Strict Mode**
- Locks license to first device
- Prevents unauthorized transfers

✅ **Max Device Enforcement**
- Configurable per license
- Prevents over-activation

✅ **Geolocation Logging**
- IP address tracking
- City/country detection
- ISP identification
- Coordinates (lat/long)

✅ **Data Isolation**
- Service key only on backend
- Frontend uses JWT tokens
- RLS policies on database
- Environment variable protection

## 🚀 Quick Start

### 1. Clone and Setup (5 minutes)
```bash
cd license-management-system
npm install
```

### 2. Supabase Setup (2 minutes)
- Create project at supabase.com
- Run `database/schema.sql` in SQL Editor
- Copy credentials to `.env.local`

### 3. Backend (1 minute)
```bash
cd backend
cp .env.example .env.local
# Fill in Supabase credentials + JWT_SECRET
npm install
npm run dev  # http://localhost:3001
```

### 4. Frontend (1 minute)
```bash
cd frontend
cp .env.example .env.local
npm install
npm run dev  # http://localhost:3000
```

### 5. Create Admin User (1 minute)
- In Supabase, create auth user
- Insert into admins table via SQL

**See [QUICKSTART.md](QUICKSTART.md) for detailed steps**

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Complete overview, architecture, features |
| [QUICKSTART.md](QUICKSTART.md) | 10-minute setup guide |
| [SETUP.md](SETUP.md) | Detailed configuration & deployment |
| [API_DOCUMENTATION.md](API_DOCUMENTATION.md) | Complete API reference with examples |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Development guidelines & standards |

## 🔌 API Endpoints

```
Client Endpoints:
  POST   /api/login                    # License activation

Admin Endpoints (JWT protected):
  POST   /api/admin-login              # Admin authentication
  GET    /api/licenses                 # List licenses
  POST   /api/licenses?action=create   # Create license
  POST   /api/licenses?action=revoke   # Revoke license
  GET    /api/logs                     # Query login logs
  GET    /api/stats                    # Dashboard stats
  GET    /api/health                   # Health check

See API_DOCUMENTATION.md for full details, examples, and response formats
```

## 🛠 Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **Frontend** | React | 18.2.0 |
| **Build** | Vite | 5.0.8 |
| **Styling** | Tailwind CSS | 3.3.6 |
| **Language** | TypeScript | 5.3.3 |
| **State** | Zustand | 4.4.1 |
| **Router** | React Router | 6.20.0 |
| **HTTP** | Axios | 1.6.2 |
| **Icons** | Lucide React | 0.292.0 |
| | | |
| **Backend** | Node.js | 18+ |
| **Framework** | Vercel Functions | - |
| **Language** | TypeScript | 5.3.3 |
| **Database** | Supabase/PostgreSQL | - |
| **Auth** | JWT | jsonwebtoken 9.1.2 |
| **ORM** | @supabase/supabase-js | 2.38.4 |
| | | |
| **Deployment** | Vercel | Free tier |
| **Database** | Supabase | Free tier |

## 📊 Data Models

### License
```typescript
{
  id: UUID
  key: string (unique)
  plan: 'starter' | 'standard' | 'premium' | 'enterprise'
  max_devices: number
  strict_mode: boolean
  revoked: boolean
  expires_at: timestamp
  created_at: timestamp
}
```

### Device
```typescript
{
  id: UUID
  license_id: UUID
  hwid: string (normalized)
  activated_at: timestamp
  last_seen: timestamp
}
```

### Login Log
```typescript
{
  id: UUID
  license_key: string
  hwid: string
  ip: string
  status: 'success' | 'failed'
  location: {
    ip: string
    city: string
    country: string
    isp: string
    latitude: number
    longitude: number
  }
  timestamp: timestamp
}
```

## 🔒 Security Considerations

1. **Secrets Management**: All sensitive keys stored in environment variables
2. **Service Role Isolation**: Backend only, never exposed to frontend
3. **JWT Tokens**: 24-hour expiration, required for admin endpoints
4. **Rate Limiting**: 5 req/15min on login to prevent brute force
5. **HWID Normalization**: Prevents device spoofing
6. **RLS Policies**: Database-level access control
7. **Geolocation Logging**: Audit trail for suspicious activity
8. **Input Validation**: All endpoints validate required parameters
9. **Error Messages**: Generic messages prevent information leakage
10. **HTTPS**: Required in production (Vercel enforces)

## ⚙️ Configuration

### Environment Variables

**Backend (.env.local)**
```
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_SERVICE_KEY=eyJhbGc...
JWT_SECRET=your-secret-key-32-chars
NODE_ENV=production
```

**Frontend (.env.local)**
```
VITE_API_URL=https://your-api.vercel.app
```

## 📈 Scalability

- ✅ **Serverless**: Vercel functions scale automatically
- ✅ **Database**: PostgreSQL handles millions of records
- ✅ **Stateless**: No session affinity required
- ✅ **Pagination**: Log queries support efficient pagination
- ✅ **Indexes**: Database indexes on frequent queries
- ✅ **Caching**: Frontend caches auth tokens

## 🎓 Learning Resources

- React: https://react.dev
- Vercel: https://vercel.com/docs
- Supabase: https://supabase.com/docs
- TypeScript: https://www.typescriptlang.org/docs
- Tailwind: https://tailwindcss.com/docs
- JWT: https://jwt.io

## 📝 Next Steps

1. ✅ Read [QUICKSTART.md](QUICKSTART.md) to get running
2. ✅ Create Supabase project and run migrations
3. ✅ Deploy backend to Vercel
4. ✅ Deploy frontend to Vercel
5. ✅ Configure admin user
6. ✅ Test license activation flow
7. ✅ Review [CONTRIBUTING.md](CONTRIBUTING.md) for development
8. ✅ Monitor logs and analytics

## 📄 License

Proprietary - All rights reserved

---

**Built with ❤️ for production use**  
Last updated: January 2025
