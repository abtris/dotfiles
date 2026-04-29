---
name: two-phase-planning
description: Two-phase planning — explore codebase read-only, then get approval before implementing
---

# /plan — Two-Phase Implementation Planning

Safe exploration before implementation. Prevents wasted effort on wrong approaches.

## When to Use

- New features (not simple bug fixes)
- Multiple valid architectural approaches
- Multi-file changes
- Refactoring existing systems
- Unclear requirements needing investigation

## Process

### Phase 1: Explore (Read-Only)

1. **Understand the request**
   - What's being asked?
   - What constraints exist?

2. **Explore the codebase**
   - Use Task(Explore) for broad questions
   - Use Glob/Grep for specific patterns
   - Read relevant files

3. **Identify decision points**
   - What approaches are possible?
   - What trade-offs exist?
   - What dependencies are involved?

### Phase 2: Present Plan

5. **Document the approach**
   - What will be created/modified
   - Key decisions and rationale
   - Risks and mitigations
   - Order of operations

6. **Ask clarifying questions** (if needed)
   - Use AskUserQuestion for decisions
   - Don't guess on ambiguous requirements

7. **Present for approval**
   ```
   ## Implementation Plan

   **Goal:** [One sentence]

   **Approach:**
   1. [Step 1]
   2. [Step 2]
   3. [Step 3]

   **Files affected:**
   - `path/to/file.go` — [what changes]

   **Risks:**
   - [Risk 1] — [mitigation]

   **Questions resolved:**
   - [Decision 1]: [choice made]

   Ready to implement? [Wait for approval]
   ```

### Phase 3: Implement (After Approval)

8. **Execute the plan**
   - Follow the documented steps
   - Note any deviations

## Skip When

- Single-line bug fixes
- Typo corrections
- User provided explicit detailed instructions
- You're certain of the approach and it's low-risk

## Example

```
User: Add caching to the API

/plan

Phase 1: Exploring...
- Found API routes in app/api/
- No existing cache layer

Options identified:
1. In-memory cache (simple, no infra)
2. Redis (scalable, requires setup)

Phase 2: Plan

## Implementation Plan

**Goal:** Add response caching to reduce database load

**Approach:** In-memory LRU cache with 5-min TTL
1. Create pkg/cache/cache.go with generic cache utility
2. Wrap expensive queries in cache layer
3. Add cache invalidation on mutations

**Files affected:**
- `pkg/cache/cache.go` — new file

**Risks:**
- Stale data — mitigated by 5-min TTL
- Memory growth — mitigated by LRU eviction

Ready to implement?

User: Yes, go ahead

[Proceeds with full implementation]
```

## Tips

- Use Task(Explore) for "where does X happen?" questions
- Don't read every file — be targeted
- If plan changes during implementation, note deviations