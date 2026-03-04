---
inclusion: manual
---

# Security Review Skill

Activate this skill to perform a security audit on the codebase or recent changes.

## Audit Process

### 1. Secrets Scan
- Search for hardcoded API keys, passwords, tokens, connection strings
- Check .env files are in .gitignore
- Verify secrets are loaded from environment variables
- Look for secrets in comments, TODOs, or test files

### 2. OWASP Top 10 Check

| # | Vulnerability | What to Check |
|---|--------------|---------------|
| 1 | Injection | All queries parameterized? User input sanitized? |
| 2 | Broken Auth | Passwords hashed (bcrypt/argon2)? JWT validated? Sessions secure? |
| 3 | Sensitive Data | HTTPS enforced? PII encrypted? Logs sanitized? |
| 4 | XXE | XML parsers configured securely? |
| 5 | Broken Access | Auth checked on every route? CORS configured? |
| 6 | Misconfiguration | Default creds changed? Debug off in prod? Security headers? |
| 7 | XSS | Output escaped? CSP set? Framework auto-escaping? |
| 8 | Insecure Deserialization | User input deserialized safely? |
| 9 | Known Vulnerabilities | Dependencies up to date? npm audit clean? |
| 10 | Insufficient Logging | Security events logged? Alerts configured? |

### 3. Dependency Audit
- Run `npm audit` or equivalent
- Check for known CVEs in dependencies
- Verify lock files are committed
- Remove unused dependencies

### 4. Dangerous Code Patterns

Flag these immediately:
- `eval()` with any external input
- Shell commands with user-provided strings
- `innerHTML` with user content
- `fetch(userProvidedUrl)` without domain whitelist
- Plaintext password comparison
- Database queries without parameterization
- File operations with user-controlled paths

## Output Format

```
[CRITICAL/HIGH/MEDIUM/LOW] Category — Description
  Location: file:line
  Risk: What could go wrong
  Fix: How to remediate
```

## Emergency Protocol

If CRITICAL vulnerability found:
1. Document it immediately
2. Fix before any other work
3. Rotate exposed secrets
4. Check for similar issues elsewhere
