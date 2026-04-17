-- Add geolocation columns to login_logs table if they don't exist

ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS city TEXT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS country TEXT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS isp TEXT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS latitude FLOAT;
ALTER TABLE login_logs ADD COLUMN IF NOT EXISTS longitude FLOAT;

-- Verify columns exist
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'login_logs' AND table_schema = 'public'
ORDER BY ordinal_position;
