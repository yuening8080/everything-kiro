---
inclusion: fileMatch
fileMatchPattern: "**/*.{jsx,tsx}"
---

# React Patterns

## Component Design

- Functional components with hooks only (no class components)
- Single responsibility — one component, one job
- Prefer composition over prop drilling (use context or composition patterns)
- Keep components under 200 lines — extract sub-components

## Hooks

- Follow Rules of Hooks (top level only, React functions only)
- Complete dependency arrays in useEffect/useMemo/useCallback
- Custom hooks for reusable stateful logic (prefix with `use`)
- Clean up side effects in useEffect return function

## Common Mistakes to Avoid

```jsx
// BAD: Missing dependency — stale closure
useEffect(() => {
  fetchData(userId);
}, []); // userId missing

// GOOD: Complete dependencies
useEffect(() => {
  fetchData(userId);
}, [userId]);

// BAD: Index as key with reorderable list
{items.map((item, i) => <Item key={i} />)}

// GOOD: Stable unique key
{items.map(item => <Item key={item.id} />)}

// BAD: State update during render
function Component() {
  const [count, setCount] = useState(0);
  setCount(count + 1); // Infinite loop!
}
```

## State Management

- Local state for component-specific data
- Lift state up only when siblings need to share it
- Context for truly global state (theme, auth, locale)
- Avoid putting everything in global state

## Performance

- Memoize expensive computations with useMemo
- Memoize callbacks passed to child components with useCallback (only when needed)
- Use React.lazy + Suspense for code splitting
- Virtualize long lists

## Accessibility

- Use semantic HTML elements (button, nav, main, article)
- Add aria-labels to interactive elements without visible text
- Ensure keyboard navigation works
- Test with screen readers when possible
