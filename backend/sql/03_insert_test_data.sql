-- INSERT TEST DATA after schema rebuild

-- 1. Insert test licenses
INSERT INTO licenses (key, plan, max_devices, strict_mode, expires_at) VALUES
('LIC-TEST-STANDARD-001', 'standard', 3, false, NOW() + INTERVAL '365 days'),
('LIC-TEST-PRO-001', 'pro', 10, false, NOW() + INTERVAL '90 days'),
('LIC-TEST-STRICT-001', 'standard', 1, true, NOW() + INTERVAL '180 days'),
('LIC-TEST-EXPIRED-001', 'standard', 3, false, NOW() - INTERVAL '30 days'),
('LIC-TEST-REVOKED-001', 'standard', 3, false, NOW() + INTERVAL '365 days');

-- 2. Revoke one license
UPDATE licenses 
SET revoked = true, revoked_at = NOW() 
WHERE key = 'LIC-TEST-REVOKED-001';

-- 3. Verify test data inserted
SELECT 'Licenses' as table_name, COUNT(*) as count FROM licenses
UNION ALL
SELECT 'Devices' as table_name, COUNT(*) as count FROM devices
UNION ALL
SELECT 'Login Logs' as table_name, COUNT(*) as count FROM login_logs;

-- 4. Show test licenses
SELECT key, plan, max_devices, strict_mode, revoked, expires_at 
FROM licenses 
WHERE key LIKE 'LIC-TEST-%'
ORDER BY created_at DESC;
