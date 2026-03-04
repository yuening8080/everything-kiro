---
inclusion: always
---

# Performance Guidelines

## Frontend

- Lazy load routes and heavy components
- Memoize expensive computations (useMemo, useCallback where it matters)
- Avoid unnecessary re-renders — check dependency arrays
- Optimize images: use appropriate formats, lazy loading, responsive sizes
- Minimize bundle size — tree-shake, code-split, avoid large dependencies
- Use virtualization for long lists (>100 items)

## Backend

- Use database indexes for frequently queried columns
- Implement pagination for list endpoints (never return unbounded results)
- Cache expensive computations and repeated queries
- Use connection pooling for database connections
- Set appropriate timeouts on external API calls
- Stream large responses instead of buffering

## General

- Measure before optimizing — don't guess at bottlenecks
- Profile with real data, not toy examples
- Set performance budgets (bundle size, response time, LCP)
- Monitor performance in production, not just development

## Anti-Patterns to Avoid

- N+1 queries (fetch related data in batch, not per-item)
- Synchronous file I/O in request handlers
- Unbounded in-memory caches
- Polling when websockets/SSE would work
- Loading entire datasets when only a subset is needed
