---
name: create-pr
description: Prepare Github PR for review
---

## Creating a New Pull Request

1. First check if project use PR template .github/pull_request_template.md if not exists use this:

```markdown
### Motivation and Context

### Special notes

### Checklist

- [ ] Described change in detail
- [ ] Doesn't include multiple separate fixes
- [ ] Proof of testing (if applicable)
- [ ] Has KR-XXX in title
```

2. Prepare your PR description following the template in @.github/pull_request_template.md

3. Check if gh pr exists, if not create it, if yes update it.

4. Create PR title

- The general idea is straightforward: adopt the well-known Conventional Commits framework, modify the parts that don't fit our needs, and add what we require—all while leveraging as much existing open-source tooling as possible.
- Example: 
      ```
      <type>[optional scope]: JIRA-ref <description>

      [optional body]

      [optional footer(s)]
      ```
- Commit types
   - There is a number of commit types that we are going to use, following a widely used commitlint tool (https://commitlint.js.org/).  The type is mandatory, but not all types require the Jira reference, see the list for details.

   ✨ feat - Features: A new feature, MUST HAVE Jira Ref
   🐛 fix - Bug Fixes: A bug fix MUST HAVE Jira Ref
   📚 docs - Documentation: Documentation only changes
   📦 refactor - Code Refactoring: A code change that neither fixes a bug nor adds a feature, style, perf etc.
   🚨 test - Tests: Adding missing tests or correcting existing tests
   ⚙️ ci - Builds and Continuous Integrations: Changes  that affect the build system e.g. updating go version, CI configuration files and scripts (example scopes: Github Actions, Jenkins)
   ♻️ chore - Chores: Removal of unused code and other changes that don't modify src or test files, e.g. modifying .gitignore
   🗑 revert - Reverts: Reverts a referenced commit

- If PR title MUST HAVE Jira Ref, ask user if you missing it. If user doesn't provide it we have to choose different type as chore instead of feat/fix.

5. Use the `gh pr create --draft` command to create a new pull request:

   ```bash
   # Basic command structure
   gh pr create --draft --title "chore(scope): Your descriptive title" --body "Your PR description" --base main 
   ```

   For more complex PR descriptions with proper formatting, use the `--body-file` option with the exact PR template structure:

   ```bash
   # Create PR with proper template structure
   gh pr create --draft --title "chore(scope): Your descriptive title" --body-file .github/pull_request_template.md --base main
   ```

6. **Template Accuracy**: Ensure your PR description precisely follows the template structure:

   - Don't modify or rename the PR-Agent sections (`pr_agent:summary` and `pr_agent:walkthrough`)
   - Keep all section headers exactly as they appear in the template
   - Don't add custom sections that aren't in the template

### Common Mistakes to Avoid

1. **Using Non-English Text**: All PR content must be in English
2. **Incorrect Section Headers**: Always use the exact section headers from the template
3. **Adding Custom Sections**: Stick to the sections defined in the template
4. **Using Outdated Templates**: Always refer to the current @.github/pull_request_template.md file
5. **Be sure that new branch is from latest main**: Always rebase your branch to main before creating a PR

### Missing Sections

Always include all template sections, even if some are marked as "N/A" or "None"

## Additional GitHub CLI PR Commands

Here are some additional useful GitHub CLI commands for managing PRs:

```bash
# List your open pull requests
gh pr list --author "@me"

# Check PR status
gh pr status

# View a specific PR
gh pr view <PR-NUMBER>

# Check out a PR branch locally
gh pr checkout <PR-NUMBER>

# Convert a draft PR to ready for review
gh pr ready <PR-NUMBER>

# Add reviewers to a PR
gh pr edit <PR-NUMBER> --add-reviewer username1,username2

# Merge a PR
gh pr merge <PR-NUMBER> --squash
```

## Using Templates for PR Creation

To simplify PR creation with consistent descriptions, you can create a template file:

1. Create a file named `pr-template.md` with your PR template
2. Use it when creating PRs:

```bash
gh pr create --draft --title "feat(scope): Your title" --body-file pr-template.md --base main
```

## Related Documentation

- [PR Template](.github/pull_request_template.md)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub CLI documentation](https://cli.github.com/manual/)
