#!/bin/bash
#
# Synapse Framework Test Script
#
# Run locally before publishing to verify commands work as expected.
# Uses Claude Code to execute commands, then validates results.
#
# Usage:
#   ./scripts/test-synapse.sh              # Run all tests
#   ./scripts/test-synapse.sh --structural # Only structural validation (no Claude)
#   ./scripts/test-synapse.sh --cleanup    # Remove test fixtures

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="$(dirname "$SCRIPT_DIR")"
TEST_DIR="${VAULT_DIR}/.test-fixtures"
FIXTURE_VAULT="${TEST_DIR}/test-vault"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

passed=0
failed=0

log_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((passed++)) || true
}

log_fail() {
    echo -e "${RED}✗${NC} $1"
    ((failed++)) || true
}

log_info() {
    echo -e "${YELLOW}→${NC} $1"
}

# =============================================================================
# Structural Validation (no Claude required)
# =============================================================================

test_structural() {
    echo ""
    echo "=== Structural Validation ==="
    echo ""

    # Test: All synapse commands exist
    log_info "Checking command files exist..."

    for cmd in synapse-setup synapse-review synapse-update synapse-publish synapse-changelog; do
        if [[ -f "${VAULT_DIR}/.claude/commands/${cmd}.md" ]]; then
            log_pass "Command exists: ${cmd}.md"
        else
            log_fail "Command missing: ${cmd}.md"
        fi
    done

    # Test: Commands have required sections
    log_info "Checking command structure..."

    for cmd_file in "${VAULT_DIR}"/.claude/commands/synapse-*.md; do
        cmd_name=$(basename "$cmd_file")

        if grep -q "^## " "$cmd_file"; then
            log_pass "${cmd_name} has sections"
        else
            log_fail "${cmd_name} missing sections"
        fi

        if grep -q "^## Usage" "$cmd_file" || grep -q "^## Example" "$cmd_file"; then
            log_pass "${cmd_name} has usage/example"
        else
            log_fail "${cmd_name} missing usage section"
        fi
    done

    # Test: README documents all commands
    log_info "Checking README documentation..."

    for cmd in synapse-setup synapse-review synapse-update synapse-publish synapse-changelog; do
        if grep -q "/${cmd}" "${VAULT_DIR}/README.md"; then
            log_pass "README documents /${cmd}"
        else
            log_fail "README missing /${cmd}"
        fi
    done

    # Test: Templates have frontmatter
    log_info "Checking template frontmatter..."

    for template in "${VAULT_DIR}"/templates/*.md; do
        template_name=$(basename "$template")

        if head -1 "$template" | grep -q "^---"; then
            log_pass "${template_name} has frontmatter"
        else
            log_fail "${template_name} missing frontmatter"
        fi
    done

    # Test: Config file is valid JSON
    log_info "Checking config file..."

    if [[ -f "${VAULT_DIR}/.claude/synapse-config.json" ]]; then
        if python3 -c "import json; json.load(open('${VAULT_DIR}/.claude/synapse-config.json'))" 2>/dev/null; then
            log_pass "synapse-config.json is valid JSON"
        else
            log_fail "synapse-config.json is invalid JSON"
        fi
    else
        log_fail "synapse-config.json missing"
    fi

    # Test: Section markers are paired (if they exist)
    log_info "Checking section markers..."

    for file in CLAUDE.md README.md; do
        filepath="${VAULT_DIR}/${file}"
        if [[ -f "$filepath" ]]; then
            start_count=$(grep -c "SYNAPSE:.*:START" "$filepath" 2>/dev/null) || start_count=0
            end_count=$(grep -c "SYNAPSE:.*:END" "$filepath" 2>/dev/null) || end_count=0

            if [[ "$start_count" -eq 0 ]] && [[ "$end_count" -eq 0 ]]; then
                log_info "${file} has no section markers (optional)"
            elif [[ "$start_count" -eq "$end_count" ]]; then
                log_pass "${file} markers are balanced (${start_count} pair(s))"
            else
                log_fail "${file} markers unbalanced (${start_count} START, ${end_count} END)"
            fi
        fi
    done

    # Test: No broken internal command references
    log_info "Checking command references..."

    # Extract all /synapse-* references from docs and check they exist
    refs=$(grep -oh '/synapse-[a-z-]*' "${VAULT_DIR}/README.md" "${VAULT_DIR}/CLAUDE.md" 2>/dev/null | sort -u)
    for ref in $refs; do
        cmd_name="${ref#/}"
        if [[ -f "${VAULT_DIR}/.claude/commands/${cmd_name}.md" ]]; then
            log_pass "Reference ${ref} resolves"
        else
            log_fail "Reference ${ref} has no command file"
        fi
    done
}

# =============================================================================
# Fixture Creation
# =============================================================================

create_test_fixture() {
    log_info "Creating test fixture at ${FIXTURE_VAULT}..."

    rm -rf "$FIXTURE_VAULT"
    mkdir -p "$FIXTURE_VAULT"
    mkdir -p "${FIXTURE_VAULT}/.claude/commands"
    mkdir -p "${FIXTURE_VAULT}/templates"
    mkdir -p "${FIXTURE_VAULT}/inbox"
    mkdir -p "${FIXTURE_VAULT}/areas"
    mkdir -p "${FIXTURE_VAULT}/people"

    # Create an "outdated" vault with older command versions
    # This simulates a user who hasn't updated

    # Minimal CLAUDE.md without proper markers
    cat > "${FIXTURE_VAULT}/CLAUDE.md" << 'EOF'
# AI Assistant Context

## Vault Owner

**Test User** - Developer at TestCorp.

## Vault Structure

Standard Obsidian vault.
EOF

    # Minimal README
    cat > "${FIXTURE_VAULT}/README.md" << 'EOF'
# Test Vault

A test vault for Synapse.
EOF

    # Old version of synapse-config
    cat > "${FIXTURE_VAULT}/.claude/synapse-config.json" << 'EOF'
{
  "source_repo": "https://github.com/julien731/synapse-pkm",
  "local_repo_path": "~/workspace/synapse-pkm",
  "branch": "main"
}
EOF

    # Old version tracking (v0.1.0)
    cat > "${FIXTURE_VAULT}/.claude/synapse-version.json" << 'EOF'
{
  "version": "0.1.0",
  "updated_at": "2026-01-01T00:00:00Z"
}
EOF

    # A sample note without proper frontmatter
    cat > "${FIXTURE_VAULT}/inbox/Quick Note.md" << 'EOF'
# Quick Note

This is a note without proper frontmatter.
It should be flagged by synapse-review.
EOF

    # A note with incomplete frontmatter
    cat > "${FIXTURE_VAULT}/areas/Project Ideas.md" << 'EOF'
---
type: area
---

# Project Ideas

Some ideas for projects.
EOF

    log_pass "Test fixture created"
}

# =============================================================================
# Claude-based Integration Tests
# =============================================================================

test_with_claude() {
    echo ""
    echo "=== Integration Tests (using Claude Code) ==="
    echo ""

    # Check if claude CLI is available
    if ! command -v claude &> /dev/null; then
        log_fail "Claude CLI not found. Install it or run with --structural only."
        return 1
    fi

    create_test_fixture

    log_info "Running /synapse-update on test fixture..."

    # Run update command
    # Note: This will prompt for confirmation. Use --dangerously-skip-permissions in CI
    cd "$FIXTURE_VAULT"

    # Create a prompt that simulates the update
    claude -p "I'm in a test vault at ${FIXTURE_VAULT}. Run /synapse-update --force and accept all updates without asking for confirmation. The source repo is the current synapse-pkm framework." --allowedTools "Read,Write,Edit,Bash,Glob,Grep" 2>&1 | head -50

    # Validate results
    log_info "Validating update results..."

    # Check if commands were copied
    for cmd in synapse-setup synapse-review synapse-update; do
        if [[ -f "${FIXTURE_VAULT}/.claude/commands/${cmd}.md" ]]; then
            log_pass "Update installed ${cmd}.md"
        else
            log_fail "Update failed to install ${cmd}.md"
        fi
    done

    # Check if CLAUDE.md has markers now
    if grep -q "SYNAPSE:" "${FIXTURE_VAULT}/CLAUDE.md" 2>/dev/null; then
        log_pass "CLAUDE.md has section markers after update"
    else
        log_fail "CLAUDE.md missing markers after update"
    fi

    # Run review on the fixture
    log_info "Running /synapse-review on test fixture..."

    claude -p "Run /synapse-review --all on this vault. Fix all issues without asking for confirmation." --allowedTools "Read,Write,Edit,Bash,Glob,Grep" 2>&1 | head -50

    # Check if notes were fixed
    if grep -q "^summary:" "${FIXTURE_VAULT}/inbox/Quick Note.md" 2>/dev/null; then
        log_pass "Review added summary to Quick Note.md"
    else
        log_fail "Review did not add summary to Quick Note.md"
    fi

    if grep -q "^summary:" "${FIXTURE_VAULT}/areas/Project Ideas.md" 2>/dev/null; then
        log_pass "Review added summary to Project Ideas.md"
    else
        log_fail "Review did not add summary to Project Ideas.md"
    fi
}

# =============================================================================
# Cleanup
# =============================================================================

cleanup() {
    log_info "Cleaning up test fixtures..."
    rm -rf "$TEST_DIR"
    log_pass "Cleanup complete"
}

# =============================================================================
# Main
# =============================================================================

main() {
    echo "========================================"
    echo "  Synapse Framework Test Suite"
    echo "========================================"

    case "${1:-}" in
        --structural)
            test_structural
            ;;
        --integration)
            test_with_claude
            ;;
        --cleanup)
            cleanup
            exit 0
            ;;
        --help)
            echo "Usage: $0 [--structural|--integration|--cleanup|--help]"
            echo ""
            echo "Options:"
            echo "  (none)        Run structural tests only"
            echo "  --structural  Run structural validation (no Claude required)"
            echo "  --integration Run integration tests (requires Claude CLI)"
            echo "  --cleanup     Remove test fixtures"
            echo "  --help        Show this help"
            exit 0
            ;;
        *)
            test_structural
            ;;
    esac

    echo ""
    echo "========================================"
    echo -e "  Results: ${GREEN}${passed} passed${NC}, ${RED}${failed} failed${NC}"
    echo "========================================"

    if [[ $failed -gt 0 ]]; then
        exit 1
    fi
}

main "$@"
