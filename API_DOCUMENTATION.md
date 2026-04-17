# License Management System - API Documentation

## Base URL

- **Development**: `http://localhost:3001`
- **Production**: `https://your-vercel-api.vercel.app`

## Authentication

Admin endpoints require JWT authentication in the `Authorization` header:

```
Authorization: Bearer <jwt_token>
```

## Endpoints

### Client Endpoints

#### POST /api/login
Activate or validate a license for a client.

**Request:**
```json
{
  "license_key": "LIC-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  "hwid": "your-device-hardware-id"
}
```

**Response (Success - 200):**
```json
{
  "success": true,
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "expires_at": "2025-01-20T10:30:00Z"
}
```

**Response (Error - 401):**
```json
{
  "success": false,
  "error": "Invalid license key"
}
```

**Status Codes:**
- `200` - Successful login
- `401` - Invalid license, expired, or device limit reached
- `400` - Missing required parameters
- `500` - Server error

**Error Messages:**
- `Invalid license key` - License doesn't exist
- `License expired` - Expiration date has passed
- `License locked to first device (strict mode)` - Strict mode violation
- `Max device limit reached` - Device activation limit exceeded

---

### Admin Endpoints

#### POST /api/admin-login
Authenticate as an admin user.

**Request:**
```json
{
  "email": "admin@example.com",
  "password": "your-password"
}
```

**Response (Success - 200):**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "uuid-here",
    "email": "admin@example.com"
  }
}
```

**Response (Error - 401):**
```json
{
  "success": false,
  "error": "Invalid credentials"
}
```

---

#### GET /api/licenses
List all licenses with device information. (Admin only)

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid-here",
      "key": "LIC-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "plan": "standard",
      "max_devices": 3,
      "strict_mode": false,
      "revoked": false,
      "expires_at": "2025-01-20T10:30:00Z",
      "created_at": "2025-01-17T10:30:00Z",
      "devices": {
        "count": 2
      }
    }
  ]
}
```

---

#### POST /api/licenses?action=create
Create a new license. (Admin only)

**Headers:**
```
Authorization: Bearer <jwt_token>
Content-Type: application/json
```

**Request:**
```json
{
  "plan": "standard",
  "max_devices": 3,
  "strict_mode": false
}
```

**Plan Values:**
- `starter` - 1 day expiration
- `standard` - 3 days expiration
- `premium` - 7 days expiration
- `enterprise` - 30 days expiration

**Response (201):**
```json
{
  "success": true,
  "data": {
    "license_key": "LIC-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "plan": "standard",
    "max_devices": 3,
    "strict_mode": false,
    "expires_at": "2025-01-20T10:30:00Z"
  }
}
```

---

#### POST /api/licenses?action=revoke
Revoke a license. (Admin only)

**Headers:**
```
Authorization: Bearer <jwt_token>
Content-Type: application/json
```

**Request:**
```json
{
  "license_key": "LIC-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "License revoked"
}
```

---

#### GET /api/logs
Retrieve login logs. (Admin only)

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Query Parameters:**
- `limit` (number, default: 50) - Results per page
- `offset` (number, default: 0) - Pagination offset
- `status` (string, optional) - Filter by status: `success` or `failed`
- `country` (string, optional) - Filter by country name

**Example:**
```
GET /api/logs?limit=20&offset=0&status=success&country=United%20States
```

**Response (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid-here",
      "license_key": "LIC-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      "hwid": "normalized-hwid",
      "ip": "192.168.1.1",
      "status": "success",
      "location": {
        "ip": "192.168.1.1",
        "city": "San Francisco",
        "country": "United States",
        "isp": "Example ISP",
        "latitude": 37.7749,
        "longitude": -122.4194
      },
      "timestamp": "2025-01-17T10:30:00Z"
    }
  ],
  "total": 150,
  "limit": 20,
  "offset": 0
}
```

---

#### GET /api/stats
Get dashboard statistics. (Admin only)

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "total_licenses": 50,
    "active_licenses": 45,
    "expired_licenses": 5,
    "total_devices": 120,
    "total_logins": 500,
    "failed_logins": 25,
    "success_rate": 95.0
  }
}
```

---

## Rate Limiting

The `/api/login` endpoint has rate limiting enabled:
- **Limit**: 5 requests per 15 minutes per IP
- **Headers**: 
  - `X-RateLimit-Limit`: Maximum requests allowed
  - `X-RateLimit-Remaining`: Requests remaining
  - `X-RateLimit-Reset`: When the limit resets (ISO timestamp)

**Response (429 - Too Many Requests):**
```json
{
  "error": "Too many requests",
  "retryAfter": 300
}
```

---

## Error Handling

All endpoints follow a consistent error response format:

```json
{
  "error": "Error message",
  "details": "Additional context (optional)"
}
```

**HTTP Status Codes:**
- `200` - Success
- `201` - Created
- `400` - Bad request (missing/invalid parameters)
- `401` - Unauthorized (invalid/missing token)
- `403` - Forbidden (insufficient permissions)
- `404` - Not found
- `405` - Method not allowed
- `429` - Too many requests (rate limited)
- `500` - Internal server error

---

## Examples

### Client License Activation

```bash
curl -X POST http://localhost:3001/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "license_key": "LIC-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "hwid": "ABC123DEF456"
  }'
```

### Admin Login

```bash
curl -X POST http://localhost:3001/api/admin-login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@example.com",
    "password": "your-password"
  }'
```

### Get Licenses (with auth)

```bash
curl -X GET http://localhost:3001/api/licenses \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..."
```

### Create License

```bash
curl -X POST "http://localhost:3001/api/licenses?action=create" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..." \
  -H "Content-Type: application/json" \
  -d '{
    "plan": "standard",
    "max_devices": 5,
    "strict_mode": true
  }'
```

### Query Logs with Filters

```bash
curl -X GET "http://localhost:3001/api/logs?limit=20&status=success&country=United%20States" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..."
```

---

## Security Notes

1. **JWT Tokens**: Valid for 24 hours from generation
2. **Service Key**: Never expose `SUPABASE_SERVICE_KEY` to the frontend
3. **HWID Normalization**: All HWIDs are normalized (lowercase, no special chars)
4. **IP Logging**: All requests log client IP and geolocation
5. **Strict Mode**: When enabled, license locks to the first device that activates it
6. **Device Limit**: Each license can activate on a maximum number of devices
7. **Rate Limiting**: Login endpoint protected against brute force attacks

---

## Webhooks (Optional Enhancement)

Future versions could include:
- POST webhook notifications on license expiration
- POST webhook on device activation
- POST webhook on suspicious login attempts
