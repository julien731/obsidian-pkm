# Synapse Testing

This directory contains tests for the Synapse framework.

## Overview

Testing Claude commands presents unique challenges since they're natural language instructions, not code. Our approach combines:

1. **Structural validation** - Fast, deterministic checks that don't require Claude
2. **Integration tests** - Full command execution using Claude CLI locally

## Running Tests

### Structural Tests (Recommended before commits)

```bash
./scripts/test-synapse.sh
# or explicitly:
./scripts/test-synapse.sh --structural
```

These tests run instantly without API calls. Run them before committing changes.

### Integration Tests (Before publishing)

```bash
./scripts/test-synapse.sh --integration
```

These tests:
- Create a test vault fixture with an "outdated" state
- Run `/synapse-update` via Claude CLI
- Run `/synapse-review` via Claude CLI
- Validate the results match expected state

**Requirements:**
- Claude CLI installed (`claude` command available)
- Sufficient API credits

### Cleanup

```bash
./scripts/test-synapse.sh --cleanup
```

Removes test fixtures from `.test-fixtures/`.

## What Structural Tests Check

| Check | Description |
|-------|-------------|
| Command files exist | All `synapse-*.md` files present in `.claude/commands/` |
| Command structure | Each command has `## Usage` or `## Example` sections |
| README documentation | All commands documented in README.md |
| Template frontmatter | All templates start with `---` (YAML frontmatter) |
| Config validity | `synapse-config.json` is valid JSON |
| Section markers | START/END markers are balanced (if present) |
| Command references | All `/synapse-*` references resolve to actual files |

## What Integration Tests Check

| Check | Description |
|-------|-------------|
| Update installs commands | After `/synapse-update`, all command files exist |
| Update adds markers | CLAUDE.md has section markers after update |
| Review adds summaries | Notes without summaries get them added |
| Review adds frontmatter | Incomplete frontmatter gets completed |

## Test Fixtures

Integration tests create a "v0.1.0" vault in `.test-fixtures/test-vault/` with:

- Minimal CLAUDE.md without section markers
- Minimal README.md
- Notes missing proper frontmatter
- Old version tracking file

This simulates a user who hasn't updated their vault.

## Limitations

### What we CAN'T test automatically:

- Whether Claude interprets instructions correctly in all edge cases
- Whether the AI's output quality meets expectations
- Subjective aspects like "is this summary good enough?"

### Non-determinism:

Integration tests may produce slightly different results each run because:
- Claude's responses vary
- File modification timestamps differ
- Order of operations may vary

For this reason, integration tests check for **presence** of expected elements rather than exact content matching.

## CI Strategy

**GitHub Actions (structural only):**
- Configured in `.github/workflows/validate.yml`
- Runs on push/PR to main when framework files change
- No API costs
- Fast feedback

Triggers on changes to:
- `.claude/commands/**`
- `templates/**`
- `CLAUDE.md`, `README.md`
- `.claude/synapse-config.json`
- `scripts/**`

**Local (integration):**
- Run manually before `/synapse-publish`
- Uses your local Claude CLI
- Catches command execution issues

## Adding New Tests

### Structural tests

Add checks to the `test_structural()` function in `test-synapse.sh`:

```bash
# Example: Check that CHANGELOG.md exists
if [[ -f "${VAULT_DIR}/CHANGELOG.md" ]]; then
    log_pass "CHANGELOG.md exists"
else
    log_fail "CHANGELOG.md missing"
fi
```

### Integration tests

Add validation to the `test_with_claude()` function after commands run:

```bash
# Example: Check that a specific field was added
if grep -q "^status:" "${FIXTURE_VAULT}/areas/Project Ideas.md"; then
    log_pass "Review added status field"
else
    log_fail "Review did not add status field"
fi
```

## Future Improvements

- [ ] Snapshot testing for framework files
- [ ] Version-specific fixtures (v0.1, v0.2, etc.)
- [ ] Parallel test execution
- [ ] Coverage reporting for which command paths are tested
- [ ] Mock Claude responses for faster CI integration tests
