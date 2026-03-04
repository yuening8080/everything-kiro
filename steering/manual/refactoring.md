---
inclusion: manual
---

# Refactoring Skill

Activate this skill for safe, systematic code improvement.

## Refactoring Principles

- **Tests first** — Ensure test coverage exists before refactoring
- **Small steps** — One change at a time, verify tests pass after each
- **No behavior change** — Refactoring changes structure, not behavior
- **Commit often** — Each successful refactoring step gets its own commit

## Common Refactoring Patterns

### Extract Function
When a block of code does something that can be named:
```
// Before: inline logic
if (user.age >= 18 && user.verified && !user.banned) { ... }

// After: extracted with clear name
if (isEligibleUser(user)) { ... }
```

### Early Return
When deep nesting makes code hard to follow:
```
// Before: nested
function process(data) {
  if (data) {
    if (data.valid) {
      // actual logic
    }
  }
}

// After: early returns
function process(data) {
  if (!data) return;
  if (!data.valid) return;
  // actual logic
}
```

### Replace Magic Numbers
```
// Before
if (retries > 3) { ... }

// After
const MAX_RETRIES = 3;
if (retries > MAX_RETRIES) { ... }
```

### Split Large Files
When a file exceeds 800 lines:
1. Identify distinct responsibilities
2. Extract each into its own module
3. Re-export from original if needed for backward compatibility
4. Update imports across codebase

### Dead Code Removal
- Remove commented-out code (it's in git history)
- Remove unused imports
- Remove unreachable branches
- Remove unused functions/variables

## Workflow

1. Identify the smell (large file, deep nesting, duplication, etc.)
2. Verify test coverage exists for affected code
3. Apply one refactoring pattern
4. Run tests — must still pass
5. Commit
6. Repeat

## Red Flags That Need Refactoring

- Functions over 50 lines
- Files over 800 lines
- Nesting deeper than 4 levels
- Duplicated code in 3+ places
- God objects/functions that do everything
- Long parameter lists (>4 params — use an options object)
