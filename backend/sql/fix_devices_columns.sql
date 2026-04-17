-- Add missing columns to devices table

-- 1. Add activated_at column if missing
ALTER TABLE devices ADD COLUMN IF NOT EXISTS activated_at TIMESTAMP WITH TIME ZONE DEFAULT now();

-- 2. Rename last_used to last_seen if needed (or add last_seen)
ALTER TABLE devices ADD COLUMN IF NOT EXISTS last_seen TIMESTAMP WITH TIME ZONE DEFAULT now();

-- 3. Verify final schema
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'devices' AND table_schema = 'public'
ORDER BY ordinal_position;

-- 4. Check if RLS is disabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'devices' AND schemaname = 'public';
