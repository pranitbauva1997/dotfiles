# API Design

<preferences>
  Follow RESTful principles
  Use standard HTTP methods (GET, POST, PUT, DELETE, PATCH)
  Use `kebab-case` for URLs
  Always include versioning in the URL
  Proper use of HTTP codes:
   - `200 OK` (success), `201 Created` (resource created), `204 No Content` (success but no response)
   - `400 Bad Request` (client error), `401 Unauthorized`, `403 Forbidden`, `404 Not Found`
   - `500 Internal Server Error` (server-side failure)
  Validate and sanitize inputs
  Allow query parameters for filtering (`/users?role=admin`)
  Support pagination (`/users?limit=10&offset=20` or `/users?page=2&size=10`)
  Make `PUT`, `DELETE`, and `PATCH` idempotent (repeating the same request has the same effect)
</preferences>

<other_references>
  Python `@~/.claude/docs/python.md`
  FastAPI `@~/.claude/docs/fastapi.md`
  Django `@~/.claude/docs/django.md`
</other_references>
