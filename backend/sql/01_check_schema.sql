-- DIAGNOSTIC: Check current database schema

-- 1. Check licenses table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'licenses' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 2. Check devices table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'devices' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 3. Check login_logs table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'login_logs' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 4. Check existing device records
SELECT COUNT(*) as device_count FROM devices;

-- 5. Check existing license records
SELECT COUNT(*) as license_count FROM licenses;

-- 6. Check RLS status on all tables
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('licenses', 'devices', 'login_logs');
