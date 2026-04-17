-- Licenses table
CREATE TABLE licenses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  key VARCHAR(255) UNIQUE NOT NULL,
  plan VARCHAR(50) NOT NULL DEFAULT 'standard',
  max_devices INTEGER NOT NULL DEFAULT 3,
  strict_mode BOOLEAN NOT NULL DEFAULT FALSE,
  revoked BOOLEAN NOT NULL DEFAULT FALSE,
  revoked_at TIMESTAMP,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_licenses_key ON licenses(key);
CREATE INDEX idx_licenses_expires_at ON licenses(expires_at);
CREATE INDEX idx_licenses_revoked ON licenses(revoked);

-- Devices table
CREATE TABLE devices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  license_id UUID NOT NULL REFERENCES licenses(id) ON DELETE CASCADE,
  hwid VARCHAR(255) NOT NULL,
  activated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  last_seen TIMESTAMP,
  UNIQUE(license_id, hwid)
);

CREATE INDEX idx_devices_license_id ON devices(license_id);
CREATE INDEX idx_devices_hwid ON devices(hwid);

-- Login logs table
CREATE TABLE login_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  license_key VARCHAR(255) NOT NULL,
  hwid VARCHAR(255) NOT NULL,
  ip VARCHAR(45) NOT NULL,
  status VARCHAR(50) NOT NULL,
  location JSONB,
  user_agent TEXT,
  timestamp TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_login_logs_timestamp ON login_logs(timestamp DESC);
CREATE INDEX idx_login_logs_license_key ON login_logs(license_key);
CREATE INDEX idx_login_logs_status ON login_logs(status);
CREATE INDEX idx_login_logs_ip ON login_logs(ip);

-- Admins table
CREATE TABLE admins (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_admins_user_id ON admins(user_id);
CREATE INDEX idx_admins_email ON admins(email);

-- Enable RLS (Row Level Security)
ALTER TABLE licenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE devices ENABLE ROW LEVEL SECURITY;
ALTER TABLE login_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE admins ENABLE ROW LEVEL SECURITY;

-- RLS Policies (allow service role to access everything)
CREATE POLICY "Service role access" ON licenses
  AS PERMISSIVE FOR ALL
  USING (auth.role() = 'service_role');

CREATE POLICY "Service role access" ON devices
  AS PERMISSIVE FOR ALL
  USING (auth.role() = 'service_role');

CREATE POLICY "Service role access" ON login_logs
  AS PERMISSIVE FOR ALL
  USING (auth.role() = 'service_role');

CREATE POLICY "Service role access" ON admins
  AS PERMISSIVE FOR ALL
  USING (auth.role() = 'service_role');
