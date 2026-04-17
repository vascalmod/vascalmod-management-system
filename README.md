# License Management System

🚀 **Production-ready License Management System**

React + Node.js + Supabase PostgreSQL | Deployed on Vercel

## Quick Links

- 📋 **Setup**: [PRODUCTION_SETUP.md](PRODUCTION_SETUP.md)
- 🚀 **Deploy**: [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md)
- 📖 **API Docs**: [API_DOCUMENTATION.md](API_DOCUMENTATION.md)
- ✅ **Checklist**: [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md)

## Features

✅ **Admin Dashboard** — License & device management  
✅ **Device Binding** — Hardware-based activation with limit enforcement  
✅ **Geolocation Tracking** — Track login attempts worldwide  
✅ **Login Audit** — Complete activity logs with filtering  
✅ **JWT Auth** — Secure admin & client authentication  
✅ **Rate Limiting** — Protection against abuse  
✅ **Responsive UI** — Desktop and mobile optimized  

## Tech Stack

| Component | Technology |
|-----------|------------|
| Frontend | React 18, Vite, TypeScript, Tailwind CSS |
| Backend | Node.js, Express, TypeScript |
| Database | Supabase PostgreSQL |
| Deployment | Vercel (Frontend & Backend) |
| State | Zustand |
| Icons | Lucide React |

## Project Structure

```
license-management-system/
├── backend/              # Node.js/Express API
│   ├── api/
│   │   ├── admin-login.ts
│   │   ├── login.ts
│   │   ├── licenses.ts
│   │   ├── logs.ts
│   │   └── stats.ts
│   ├── lib/
│   │   ├── auth.ts
│   │   └── rateLimit.ts
│   ├── dev.ts
│   ├── package.json
│   └── vercel.json
├── frontend/             # React/Vite app
│   ├── src/
│   │   ├── pages/
│   │   ├── components/
│   │   ├── store/
│   │   ├── lib/
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── package.json
│   └── vite.config.ts
└── database/
    └── schema.sql       # PostgreSQL schema
```

## Getting Started

### Development
```bash
npm run install-all    # Install all dependencies
npm run dev            # Start both frontend and backend
```

### Production Deployment
1. Follow [PRODUCTION_SETUP.md](PRODUCTION_SETUP.md) for environment configuration
2. Follow [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md) for Vercel deployment

## API Overview

**Admin Endpoints** (require JWT authentication)
- `POST /api/admin-login` — Admin authentication
- `GET /api/licenses` — List all licenses
- `POST /api/licenses` — Create license
- `PUT /api/licenses/:id` — Revoke license
- `GET /api/logs` — View login logs
- `GET /api/stats` — Dashboard statistics

**Client Endpoints**
- `POST /api/login` — Activate license
- `GET /api/health` — Health check

See [API_DOCUMENTATION.md](API_DOCUMENTATION.md) for detailed specifications.

## Database

**Tables:**
- `licenses` — License keys and configurations
- `devices` — Device bindings per license
- `login_logs` — Login attempts and geolocation
- `admins` — Administrator accounts

## Security

- 🔐 JWT authentication for admin endpoints
- 🔐 Rate limiting on all endpoints
- 🔐 HWID normalization and validation
- 🔐 Device limit enforcement
- 🔐 Geolocation logging
- 🔐 Supabase RLS policies

## Environment Variables

See [PRODUCTION_SETUP.md](PRODUCTION_SETUP.md) for complete environment configuration.

## Monitoring & Support

- **Vercel Dashboard** — Deployment status and logs
- **Supabase Dashboard** — Database health and metrics
- **Application Logs** — Error tracking and debugging

## Documentation

| Document | Purpose |
|----------|---------|
| [PRODUCTION_SETUP.md](PRODUCTION_SETUP.md) | Environment setup & security configuration |
| [VERCEL_DEPLOYMENT.md](VERCEL_DEPLOYMENT.md) | Vercel deployment walkthrough |
| [API_DOCUMENTATION.md](API_DOCUMENTATION.md) | Complete API reference |
| [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md) | Pre-deployment verification |

## License

Proprietary — All rights reserved
