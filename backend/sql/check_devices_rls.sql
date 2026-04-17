-- Check devices table for RLS and records

-- 1. Check RLS status on devices table
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'devices' AND schemaname = 'public';

-- 2. Check for any RLS policies on devices
SELECT policyname, permissive, roles, cmd 
FROM pg_policies 
WHERE tablename = 'devices';

-- 3. Check actual device records
SELECT COUNT(*) as device_count FROM devices;

-- 4. Show actual device data
SELECT id, license_id, hwid, ip, activated_at, last_seen 
FROM devices 
ORDER BY activated_at DESC 
LIMIT 20;

-- 5. Check licenses table to verify license IDs exist
SELECT id, key FROM licenses LIMIT 5;
