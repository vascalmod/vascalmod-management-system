-- FIX: Reset devices table and add geolocation columns

-- 1. Drop all existing RLS policies on devices table
DROP POLICY IF EXISTS "service_role_all" ON devices;
DROP POLICY IF EXISTS "Enable read access for all users" ON devices;
DROP POLICY IF EXISTS "Enable write access for service role" ON devices;
DROP POLICY IF EXISTS "Enable all for service_role" ON devices;

-- 2. Disable RLS (make absolutely sure)
ALTER TABLE devices DISABLE ROW LEVEL SECURITY;

-- 3. Add geolocation columns to login_logs
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS city TEXT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS country TEXT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS isp TEXT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS latitude FLOAT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS longitude FLOAT;

-- 4. Verify
SELECT tablename, rowsecurity FROM pg_tables WHERE tablename = 'devices';
SELECT column_name FROM information_schema.columns WHERE table_name = 'login_logs' ORDER BY ordinal_position;
