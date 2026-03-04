---
inclusion: always
---

# Testing Requirements

## Coverage Target: 80%+

All new code should have test coverage. Three test types required:

1. **Unit Tests** — Individual functions, utilities, components
2. **Integration Tests** — API endpoints, database operations, service interactions
3. **E2E Tests** — Critical user flows via Playwright or similar

## Test-Driven Development

Preferred workflow for new features:
1. Write test first (RED) — test should fail
2. Write minimal implementation (GREEN) — test should pass
3. Refactor (IMPROVE) — clean up while tests stay green
4. Verify coverage meets 80%+

## Test Quality

- Test behavior, not implementation details
- Each test should have a single clear assertion focus
- Use descriptive test names that explain the scenario
- Test edge cases: empty inputs, null values, boundary conditions, error paths
- Mock external dependencies, not internal logic
- Keep tests independent — no shared mutable state

## Troubleshooting Failures

1. Check test isolation (no shared state between tests)
2. Verify mocks are correct and up to date
3. Fix implementation, not tests (unless tests are wrong)
4. Run tests in isolation to find ordering issues
