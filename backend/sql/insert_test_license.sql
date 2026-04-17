-- Insert test licenses for development and testing

-- Test License 1: Standard plan, 3 devices, expires in 365 days
INSERT INTO licenses (key, plan, max_devices, expires_at, strict_mode, revoked, created_at)
VALUES (
  'LIC-TEST-STANDARD-001',
  'standard',
  3,
  NOW() + INTERVAL '365 days',
  false,
  false,
  NOW()
) ON CONFLICT (key) DO NOTHING;

-- Test License 2: Pro plan, 10 devices, expires in 90 days
INSERT INTO licenses (key, plan, max_devices, expires_at, strict_mode, revoked, created_at)
VALUES (
  'LIC-TEST-PRO-001',
  'pro',
  10,
  NOW() + INTERVAL '90 days',
  false,
  false,
  NOW()
) ON CONFLICT (key) DO NOTHING;

-- Test License 3: Strict mode (locked to first device), expires in 180 days
INSERT INTO licenses (key, plan, max_devices, expires_at, strict_mode, revoked, created_at)
VALUES (
  'LIC-TEST-STRICT-001',
  'standard',
  1,
  NOW() + INTERVAL '180 days',
  true,
  false,
  NOW()
) ON CONFLICT (key) DO NOTHING;

-- Test License 4: Expired license
INSERT INTO licenses (key, plan, max_devices, expires_at, strict_mode, revoked, created_at)
VALUES (
  'LIC-TEST-EXPIRED-001',
  'standard',
  3,
  NOW() - INTERVAL '30 days',
  false,
  false,
  NOW()
) ON CONFLICT (key) DO NOTHING;

-- Test License 5: Revoked license
INSERT INTO licenses (key, plan, max_devices, expires_at, strict_mode, revoked, created_at)
VALUES (
  'LIC-TEST-REVOKED-001',
  'standard',
  3,
  NOW() + INTERVAL '365 days',
  false,
  true,
  NOW()
) ON CONFLICT (key) DO NOTHING;

-- Verify inserted licenses
SELECT key, plan, max_devices, expires_at, strict_mode, revoked FROM licenses 
WHERE key LIKE 'LIC-TEST-%' 
ORDER BY created_at DESC;
