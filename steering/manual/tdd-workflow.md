---
inclusion: manual
---

# TDD Workflow Skill

Activate this skill when implementing new features, fixing bugs, or refactoring code.

## The Cycle: RED → GREEN → REFACTOR

### Step 1: Define the Interface (SCAFFOLD)
- Define types/interfaces for inputs and outputs
- Create function stubs that throw "Not implemented"
- Clarify the contract before writing any logic

### Step 2: Write Failing Tests (RED)
- Write tests that describe the desired behavior
- Cover happy path, edge cases, and error scenarios
- Run tests — they MUST fail (confirms tests are actually testing something)

### Step 3: Implement Minimal Code (GREEN)
- Write the simplest code that makes all tests pass
- Don't optimize yet — just make it work
- Run tests — they should all pass now

### Step 4: Refactor (IMPROVE)
- Clean up the implementation while keeping tests green
- Extract constants, improve naming, reduce duplication
- Run tests after each refactoring step

### Step 5: Verify Coverage
- Check coverage is at 80%+
- Add tests for any uncovered paths
- Focus on meaningful coverage, not just line count

## Test Structure Template

```
describe('[Module/Function Name]', () => {
  describe('happy path', () => {
    it('should [expected behavior] when [condition]', () => {
      // Arrange → Act → Assert
    });
  });

  describe('edge cases', () => {
    it('should handle empty input', () => {});
    it('should handle null/undefined', () => {});
    it('should handle boundary values', () => {});
  });

  describe('error cases', () => {
    it('should throw when [invalid condition]', () => {});
    it('should return fallback when [failure condition]', () => {});
  });
});
```

## Rules

- NEVER write implementation before tests
- NEVER modify tests to make them pass (fix the implementation)
- Each test should test ONE behavior
- Tests should be independent (no shared mutable state)
- Mock external dependencies, not internal logic
