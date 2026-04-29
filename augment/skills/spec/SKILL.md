---
name: spec-for-planning-work
description: Quick feature breakdown for planning
---

# /spec — Feature Planning

Lightweight spec for planning work.

## Usage

```
/spec <feature-name>
```

## Output Format

```markdown
# Feature: [Name]

**Goal:** [One sentence — what does this do for users?]

## Tasks

| Task | Output |
|------|--------|
| [Task 1] | [Deliverable] |
| [Task 2] | [Deliverable] |
| [Task 3] | [Deliverable] |

## Decisions

| Decision | Choice | Why |
|----------|--------|-----|
| [Topic] | [Choice] | [Rationale] |

## Danger Zones

[Any overlap with _FRAGILE.md areas?]
```

## Keep It Simple

- Don't over-plan. 5-10 tasks max.
- Skip sections that don't apply.
- This is a starting point, not a contract.

## Example

```
/spec user-profiles

---

# Feature: User Profiles

**Goal:** Users can view and edit their profile information.

## Tasks

| Task | Output |
|------|--------|
| Add profile fields migration | `migrations/xxx.sql` |
| RLS policies for profile access | Supabase policies |
| GET/PATCH endpoints | API routes |
| Profile view screen | `app/profile/[id].tsx` |
| Profile edit form | `components/ProfileForm.tsx` |

## Decisions

| Decision | Choice | Why |
|----------|--------|-----|
| Soft deletes | Yes | Users may want account recovery |

## Danger Zones

None — new feature, doesn't touch existing fragile areas.
```