-- URGENT: Disable RLS on devices table before rebuild

-- 1. Drop all existing policies on devices
DROP POLICY IF EXISTS "Enable read access for all users" ON devices;
DROP POLICY IF EXISTS "Enable write access for service role" ON devices;
DROP POLICY IF EXISTS "Enable all for service_role" ON devices;
DROP POLICY IF EXISTS "service_role_all" ON devices;

-- 2. Disable RLS completely on devices
ALTER TABLE devices DISABLE ROW LEVEL SECURITY;

-- 3. Verify RLS is disabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename IN ('devices', 'licenses', 'login_logs') 
AND schemaname = 'public';

-- 4. Show current devices table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'devices' AND table_schema = 'public'
ORDER BY ordinal_position;
