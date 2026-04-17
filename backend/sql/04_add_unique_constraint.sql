-- Ensure unique constraint on devices table to prevent duplicate registrations

-- 1. Drop existing constraint if it exists
ALTER TABLE devices DROP CONSTRAINT IF EXISTS unique_license_hwid;

-- 2. Add unique constraint to prevent duplicate device registrations
ALTER TABLE devices 
ADD CONSTRAINT unique_license_hwid UNIQUE (license_key, hwid);

-- 3. Verify constraint was added
SELECT constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'devices' AND table_schema = 'public';

-- 4. Verify current device count per license
SELECT license_key, COUNT(*) as device_count, 
       (SELECT max_devices FROM licenses WHERE licenses.key = devices.license_key LIMIT 1) as max_allowed
FROM devices
GROUP BY license_key
ORDER BY license_key;
