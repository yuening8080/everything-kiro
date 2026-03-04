# Everything Kiro

**The performance optimization system for [Kiro IDE](https://kiro.dev).** Steering rules, agent hooks, and MCP configurations — production-ready and evolved for real-world AI-assisted development.

Not just configs. A complete system that makes Kiro more consistent, more systematic, and less likely to skip steps. Encoding your team's standards into steering rules, automating quality checks with hooks, and providing structured workflows as on-demand manual steering.

Inspired by [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — adapted for Kiro's native capabilities: steering files, agent hooks, specs, and MCP integrations.

---

## Why This Exists

AI coding assistants are good most of the time. The problem is consistency. Without explicit rules:

- Security checks get skipped when context is long
- Commit messages drift from conventions
- Tests get written after implementation (or not at all)
- Language-specific best practices get missed

Everything Kiro closes the gap between best-case and average-case behavior by encoding standards directly into the system. The rules are always there — not as suggestions, but as loaded context that shapes every interaction.

---

## What's Inside

```
everything-kiro/
├── steering/
│   ├── always/              # Loaded into every conversation
│   │   ├── coding-style.md      # Immutability, file org, error handling
│   │   ├── git-workflow.md       # Conventional commits, branching, PR process
│   │   ├── testing.md            # TDD workflow, 80% coverage, test types
│   │   ├── security.md           # OWASP Top 10, secret management, dangerous patterns
│   │   ├── performance.md        # Frontend/backend optimization, anti-patterns
│   │   └── patterns.md           # SOLID, design patterns, architecture guidelines
│   ├── conditional/         # Loaded when matching files are opened
│   │   ├── react-patterns.md     # Hooks, components, state, accessibility
│   │   ├── typescript-strict.md  # Type safety, generics, discriminated unions
│   │   ├── node-backend.md       # Express, middleware, DB, API design
│   │   └── python-patterns.md    # PEP 8, async, pytest, project structure
│   └── manual/              # Activated on-demand with # in chat
│       ├── tdd-workflow.md       # RED → GREEN → REFACTOR cycle
│       ├── code-review.md        # Severity-ranked review checklist
│       ├── security-review.md    # Full OWASP audit workflow
│       ├── planning.md           # Phased implementation planning
│       ├── refactoring.md        # Safe refactoring patterns
│       └── e2e-testing.md        # Playwright patterns and Page Object Model
├── hooks/                   # Automated agent actions on IDE events
│   ├── security-check.json       # Scan for secrets before every file write
│   ├── validate-api-changes.json # Check frontend/backend sync on route edits
│   ├── review-before-push.json   # Verify tests/secrets before git push
│   ├── lint-on-save.json         # Auto-lint JS/TS files on save
│   ├── test-on-save.json         # Run related tests when test files change
│   ├── commit-message.json       # Generate conventional commit (manual trigger)
│   └── post-task-tests.json      # Run test suite after spec task completion
├── mcp/
│   └── mcp.json             # MCP server configurations (AWS docs, Playwright, fetch)
├── install.sh               # Installer script
└── README.md
```

---

## How It Works

### Steering Rules (Always-On)

These load into every Kiro conversation automatically. You don't activate them — they're just there, shaping behavior:

- **coding-style.md** — Enforces immutability, small files, proper error handling, input validation
- **security.md** — OWASP awareness, secret detection, dangerous pattern flagging
- **testing.md** — TDD workflow, 80% coverage target, test quality standards
- **git-workflow.md** — Conventional commits, branching strategy, pre-commit checklist
- **performance.md** — Lazy loading, pagination, caching, N+1 prevention
- **patterns.md** — SOLID principles, composition over inheritance, clean architecture

### Conditional Steering (File-Match)

Loaded automatically when you open matching files — no wasted context on irrelevant rules:

| File | Triggers On | What It Adds |
|------|------------|-------------|
| `react-patterns.md` | `*.jsx`, `*.tsx` | Hook rules, component patterns, accessibility |
| `typescript-strict.md` | `*.ts`, `*.tsx` | Type safety, avoid `any`, discriminated unions |
| `node-backend.md` | `server.js`, `*route*.js` | Express patterns, parameterized queries, API design |
| `python-patterns.md` | `*.py` | PEP 8, type hints, pytest, async patterns |

### Manual Steering (On-Demand)

Activate in chat by typing `#name`. These provide structured workflows loaded into context on demand:

| Steering File | What It Does |
|-------|-------------|
| `#tdd-workflow` | Strict RED → GREEN → REFACTOR cycle with test templates |
| `#code-review` | Severity-ranked checklist (CRITICAL → LOW) with confidence filtering |
| `#security-review` | Full OWASP Top 10 audit with dependency scanning |
| `#planning` | Phased implementation planning with risks and testing strategy |
| `#refactoring` | Safe refactoring patterns: extract, early return, dead code removal |
| `#e2e-testing` | Playwright E2E patterns with Page Object Model |

### Agent Hooks

Automated actions triggered by IDE events — catches things you'd forget in a long session:

| Hook | Trigger | What It Does |
|------|---------|-------------|
| Security Check | Before every file write | Scans for hardcoded secrets and dangerous patterns |
| API Validation | Backend route file edited | Checks if frontend still matches changed endpoints |
| Review Before Push | Before shell commands | Verifies tests/secrets before `git push` |
| Lint on Save | JS/TS file saved | Auto-runs ESLint with fixes |
| Test on Save | Test file saved | Runs related tests automatically |
| Commit Message | Manual trigger | Generates conventional commit from current diff |
| Post-Task Tests | Spec task completed | Runs full test suite to catch regressions |

---

## Quick Start

### Option 1: Installer Script

```bash
# Clone the repo
git clone git@ssh.gitlab.aws.dev:nyue/everything-kiro.git
cd everything-kiro

# Install into a project
./install.sh /path/to/your/project

# Or install globally (user-level, applies to all projects)
./install.sh --global
```

The installer copies files without overwriting existing ones — safe to run multiple times.

### Option 2: Manual Copy

Pick what you need:

```bash
git clone git@ssh.gitlab.aws.dev:nyue/everything-kiro.git

# Copy steering rules to your project
cp everything-kiro/steering/always/*.md /path/to/project/.kiro/steering/
cp everything-kiro/steering/conditional/*.md /path/to/project/.kiro/steering/
cp everything-kiro/steering/manual/*.md /path/to/project/.kiro/steering/

# Copy hooks
cp everything-kiro/hooks/*.json /path/to/project/.kiro/hooks/

# Copy MCP config (if you don't have one already)
cp everything-kiro/mcp/mcp.json /path/to/project/.kiro/settings/mcp.json
```

### Option 3: Cherry-Pick

Just grab individual files. Every steering file and hook is self-contained — no dependencies between them.

---

## Customization

Everything is markdown and JSON. Edit to match your team:

- **Add language rules** — Create new files in `steering/conditional/` with `fileMatchPattern`
- **Add manual steering** — Create new files in `steering/manual/` with `inclusion: manual`
- **Adjust hooks** — Edit trigger patterns, change commands, add new automations
- **Add MCP servers** — Extend `mcp/mcp.json` with your team's tools

### Steering File Anatomy

```markdown
---
inclusion: always          # always | fileMatch | manual
fileMatchPattern: "*.py"   # only for fileMatch inclusion
---

# Your Rule Title

Your guidelines here. Kiro reads this as context
and follows it during every interaction.
```

### Hook File Anatomy

```json
{
  "name": "My Hook",
  "version": "1.0.0",
  "when": {
    "type": "fileEdited",
    "patterns": ["*.ts"]
  },
  "then": {
    "type": "runCommand",
    "command": "npm run lint"
  }
}
```

---

## Philosophy

1. **Steering over prompting** — Encode standards once, apply everywhere
2. **Hooks over reminders** — Automate what you'd otherwise forget
3. **Manual steering over copy-paste** — Reusable workflows activated on demand
4. **Conditional over bloated** — Load context only when relevant
5. **Minimal over maximal** — Every rule earns its place

---

## What This Is NOT

- Not a plugin system (Kiro doesn't have one yet)
- Not a replacement for project-specific steering (add your own alongside these)
- Not prescriptive about your stack (the conditional rules only load when relevant)

---

## Contributing

Add your own steering rules, hooks, or manual steering files and submit a merge request. Each file should be self-contained and follow the patterns above.

---

## License

MIT
