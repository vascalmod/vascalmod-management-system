-- DIAGNOSTIC: Check database state

-- 1. Check if geolocation columns exist in login_logs
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'login_logs' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 2. Check if RLS policies exist on devices table (even if disabled)
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'devices' AND schemaname = 'public';

-- 3. List all policies on devices table
SELECT policyname, permissive, roles, cmd, qual, with_check 
FROM pg_policies 
WHERE tablename = 'devices';

-- 4. Check actual device records in database
SELECT id, license_id, hwid, ip, activated_at, last_seen 
FROM devices 
ORDER BY activated_at DESC 
LIMIT 10;

-- 5. Check login_logs table structure
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'login_logs' AND table_schema = 'public'
ORDER BY ordinal_position;
