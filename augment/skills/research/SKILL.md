---
name: research
description: Deep research in isolated context — explore without polluting main conversation
---

# /research — Isolated Deep Exploration

Research questions in a forked context. Results return to main conversation without the exploration noise.

## When to Use

- "How does X work in this codebase?"
- "What's the pattern for Y?"
- "Find all places where Z happens"
- Exploratory questions that might take many file reads
- Research that shouldn't clutter main conversation

## How It Works

1. **Forked context** — runs in separate conversation
2. **Read-only tools** — can't modify files
3. **Returns summary** — main conversation gets distilled findings
4. **No context pollution** — exploration steps don't consume main context

## What You Can Do

- Read files (unlimited)
- Search with Glob/Grep
- Web search for external context
- Fetch documentation pages

## What You Can't Do

- Modify files
- Run arbitrary commands
- Access MCP servers (background limitation)

## Output Format

Return findings as a structured summary:

```
## Research: [Topic]

**Question:** [What was asked]

**Findings:**
1. [Key finding 1]
   - Location: `path/to/file.ts:123`
   - Detail: [explanation]

2. [Key finding 2]
   - Location: `path/to/other.ts:45`
   - Detail: [explanation]

**Pattern identified:**
[If there's a consistent pattern, describe it]

**Related files:**
- `file1.ts` — [relevance]
- `file2.ts` — [relevance]

**Recommendations:**
- [Action 1]
- [Action 2]
```

## Example

```
User: /research how does authentication work in this app?

[Forked agent explores auth system]

## Research: Authentication Flow

**Question:** How does authentication work?

**Findings:**
1. Supabase Auth with Google OAuth
   - Location: `lib/supabase.ts:12`
   - Config in `app/_layout.tsx`

2. Session stored in SecureStore (mobile)
   - Location: `lib/auth/storage.ts:34`
   - Chunked due to 2048 byte iOS limit

3. Auth state managed by AuthProvider
   - Location: `providers/AuthProvider.tsx`
   - Exposes: user, session, signIn, signOut

**Pattern:**
Auth check → SecureStore → Supabase verify → AuthContext

**Related files:**
- `middleware.ts` — route protection
- `app/(auth)/` — login/signup screens
- `docs/_FRAGILE.md` — auth danger zones

**Recommendations:**
- Check _FRAGILE.md before modifying auth
- Test both web and mobile flows
```

## Tips

- Be specific in your research question
- Results are summarized — ask follow-ups in main conversation if needed
- For implementation planning, use `/plan` instead
- For quick lookups, direct Glob/Grep may be faster