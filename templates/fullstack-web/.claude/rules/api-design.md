---
globs: ["src/routes/**", "src/api/**", "src/controllers/**"]
---

# API Design Rules

- All API endpoints return JSON with consistent structure: `{ data, error, meta }`
- Use appropriate HTTP status codes (200, 201, 400, 401, 403, 404, 500)
- Validate all input at the controller layer before passing to services
- Never expose internal error details to clients in production
- All endpoints require authentication unless explicitly marked as public
- Rate limiting on all public endpoints
