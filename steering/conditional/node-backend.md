---
inclusion: fileMatch
fileMatchPattern: "**/{server,app,route,controller,middleware}*.{js,ts}"
---

# Node.js Backend Patterns

## Express Best Practices

- Use middleware for cross-cutting concerns (auth, logging, validation, error handling)
- Separate route definitions from business logic
- Use async/await with proper error handling (wrap in try/catch or use express-async-errors)
- Set appropriate HTTP status codes

## Error Handling

```javascript
// Centralized error handler middleware (register last)
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    error: process.env.NODE_ENV === 'production'
      ? 'Internal server error'
      : err.message
  });
});
```

- Never expose stack traces in production
- Log errors with context (request ID, user, endpoint)
- Use custom error classes for different error types
- Always call `next(err)` in middleware to propagate errors

## Database

- ALWAYS use parameterized queries — never string concatenation
- Use transactions for multi-step operations
- Close connections/pools on shutdown
- Add indexes for frequently queried columns
- Paginate list endpoints

## Security

- Validate all request body/params/query with a schema (Joi, Zod, etc.)
- Use helmet for security headers
- Configure CORS properly (not `*` in production)
- Rate limit sensitive endpoints (login, signup, password reset)
- Sanitize user input before storage or display

## API Design

- RESTful naming: nouns for resources, HTTP verbs for actions
- Consistent response format: `{ data, error, meta }`
- Use proper status codes: 200, 201, 400, 401, 403, 404, 500
- Version your API if it's public
