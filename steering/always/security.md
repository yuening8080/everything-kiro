---
inclusion: always
---

# Security Guidelines

## Mandatory Checks Before Any Commit

- [ ] No hardcoded secrets (API keys, passwords, tokens, connection strings)
- [ ] All user inputs validated and sanitized
- [ ] SQL injection prevention (parameterized queries only)
- [ ] XSS prevention (sanitized/escaped output)
- [ ] Authentication/authorization verified on protected routes
- [ ] Error messages don't leak sensitive data or stack traces
- [ ] No sensitive data in logs

## Secret Management

- NEVER hardcode secrets in source code
- ALWAYS use environment variables or a secret manager
- Validate required secrets are present at startup
- Rotate any secrets that may have been exposed
- Use .env files locally, never commit them

## OWASP Top 10 Awareness

When writing code that handles user input, auth, or data:
1. **Injection** — Always use parameterized queries
2. **Broken Auth** — Hash passwords (bcrypt/argon2), validate JWTs
3. **Sensitive Data** — Encrypt PII, enforce HTTPS, sanitize logs
4. **XSS** — Escape output, use framework auto-escaping, set CSP headers
5. **Broken Access Control** — Check auth on every route, configure CORS properly
6. **Misconfiguration** — No default creds, debug mode off in prod
7. **Known Vulnerabilities** — Keep dependencies updated, run `npm audit`

## Dangerous Patterns to Flag Immediately

| Pattern | Severity | Fix |
|---------|----------|-----|
| Hardcoded secrets | CRITICAL | Use `process.env` |
| String-concatenated SQL | CRITICAL | Parameterized queries |
| `innerHTML = userInput` | HIGH | Use `textContent` or sanitizer |
| No auth check on route | CRITICAL | Add auth middleware |
| Logging passwords/tokens | MEDIUM | Sanitize log output |
| `eval()` with user input | CRITICAL | Never use eval with external data |

## If a Security Issue Is Found

1. STOP current work
2. Fix the vulnerability immediately
3. Rotate any exposed secrets
4. Check for similar issues elsewhere in codebase
