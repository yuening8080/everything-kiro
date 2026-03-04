---
inclusion: fileMatch
fileMatchPattern: "**/*.{ts,tsx}"
---

# TypeScript Patterns

## Type Safety

- Enable strict mode in tsconfig.json
- Avoid `any` — use `unknown` when type is truly unknown, then narrow
- Prefer interfaces for object shapes, types for unions/intersections
- Use generics to write reusable, type-safe code
- Leverage discriminated unions for state machines

## Common Patterns

```typescript
// GOOD: Discriminated union for state
type RequestState<T> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: Error };

// GOOD: Type narrowing with guards
function isUser(value: unknown): value is User {
  return typeof value === 'object' && value !== null && 'id' in value;
}

// BAD: Using `any` to bypass type checking
const data: any = fetchData(); // Loses all type safety
```

## Avoid

- `any` type (use `unknown` + type guards instead)
- Type assertions (`as`) unless you've verified the type
- Non-null assertions (`!`) — handle null/undefined explicitly
- Enums in most cases — prefer const objects or union types

## Best Practices

- Export types alongside their implementations
- Use `readonly` for data that shouldn't be mutated
- Prefer `Record<K, V>` over `{ [key: string]: V }`
- Use `satisfies` operator for type checking without widening
- Keep type definitions close to where they're used
