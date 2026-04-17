-- CLEAN REBUILD: Drop and recreate all tables with correct schema

-- 1. Drop existing tables (in correct order due to foreign keys)
DROP TABLE IF EXISTS login_logs CASCADE;
DROP TABLE IF EXISTS devices CASCADE;
DROP TABLE IF EXISTS licenses CASCADE;
DROP TABLE IF EXISTS admins CASCADE;

-- 2. Create licenses table
CREATE TABLE licenses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  key TEXT UNIQUE NOT NULL,
  plan TEXT NOT NULL DEFAULT 'standard',
  max_devices INTEGER NOT NULL DEFAULT 3,
  strict_mode BOOLEAN DEFAULT false,
  revoked BOOLEAN DEFAULT false,
  revoked_at TIMESTAMP WITH TIME ZONE,
  expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- 3. Create devices table
CREATE TABLE devices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  license_key TEXT NOT NULL REFERENCES licenses(key) ON DELETE CASCADE,
  hwid TEXT NOT NULL,
  ip TEXT,
  activated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  last_seen TIMESTAMP WITH TIME ZONE DEFAULT now(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  UNIQUE(license_key, hwid)
);

-- 4. Create login_logs table
CREATE TABLE login_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  license_key TEXT NOT NULL REFERENCES licenses(key) ON DELETE CASCADE,
  hwid TEXT NOT NULL,
  ip TEXT,
  city TEXT,
  country TEXT,
  isp TEXT,
  latitude FLOAT,
  longitude FLOAT,
  status TEXT NOT NULL DEFAULT 'failed',
  user_agent TEXT,
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- 5. Create admins table
CREATE TABLE admins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  email TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- 6. Create indexes for better performance
CREATE INDEX idx_licenses_key ON licenses(key);
CREATE INDEX idx_devices_license_key ON devices(license_key);
CREATE INDEX idx_devices_hwid ON devices(hwid);
CREATE INDEX idx_login_logs_license_key ON login_logs(license_key);
CREATE INDEX idx_login_logs_timestamp ON login_logs(timestamp DESC);

-- 7. Disable RLS for development (enable proper policies in production)
ALTER TABLE licenses DISABLE ROW LEVEL SECURITY;
ALTER TABLE devices DISABLE ROW LEVEL SECURITY;
ALTER TABLE login_logs DISABLE ROW LEVEL SECURITY;
ALTER TABLE admins DISABLE ROW LEVEL SECURITY;

-- 8. Verify tables created
SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('licenses', 'devices', 'login_logs', 'admins')
ORDER BY tablename;

-- 9. Verify column structure for devices table
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'devices' AND table_schema = 'public'
ORDER BY ordinal_position;
