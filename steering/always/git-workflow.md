---
inclusion: always
---

# Git Workflow

## Commit Messages

Use conventional commit format: `type(scope): description`

Types: feat, fix, docs, style, refactor, test, chore
- Keep first line under 50 characters
- Use imperative mood ("Add feature" not "Added feature")
- Include body for complex changes

Examples:
```
feat(cart): add quantity validation
fix(auth): handle expired token refresh
refactor(api): extract middleware helpers
test(products): add edge case coverage
```

## Branching

- Feature branches for new development: `feature/user-auth`
- Bug fix branches: `fix/login-bug`
- Keep `main` stable and deployable
- Delete merged branches

## Before Committing

- [ ] Run tests and verify they pass
- [ ] No hardcoded secrets or API keys
- [ ] No debug logging left in code
- [ ] Changes are logically grouped (atomic commits)
- [ ] Commit message follows conventional format

## Security

- NEVER commit secrets, API keys, or passwords
- Use environment variables for configuration
- Review diffs for sensitive information before pushing
- Use .gitignore to exclude build artifacts, node_modules, .env files
