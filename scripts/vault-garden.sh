#!/bin/bash
#
# Vault Gardening Script
# Performs daily maintenance on the Obsidian vault
#

set -e

VAULT_DIR="/Users/julien/Documents/Obsidian"
TODAY=$(date +%Y-%m-%d)
STALE_DAYS=30
STALE_THRESHOLD=$(date -v-${STALE_DAYS}d +%Y-%m-%d 2>/dev/null || date -d "${STALE_DAYS} days ago" +%Y-%m-%d)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🌱 Starting Vault Gardening — ${TODAY}${NC}"
echo ""

# ============================================================================
# 1. GIT SYNC
# ============================================================================
echo -e "${BLUE}## Git Sync${NC}"
cd "$VAULT_DIR"

# Check if we're in a git repo
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Not a git repository. Skipping git sync.${NC}"
else
    # Pull latest changes
    git fetch origin main 2>/dev/null || git fetch origin master 2>/dev/null || true
    
    # Get new files that landed since last run
    NEW_FILES=$(git diff --name-only HEAD@{1} HEAD 2>/dev/null | grep -E '\.md$' || true)
    
    if [ -n "$NEW_FILES" ]; then
        echo "New files via git pull:"
        echo "$NEW_FILES" | head -10 | sed 's/^/- /'
        [ $(echo "$NEW_FILES" | wc -l) -gt 10 ] && echo "... and $(($(echo "$NEW_FILES" | wc -l) - 10)) more"
    else
        echo "No new markdown files from git."
    fi
fi
echo ""

# ============================================================================
# 2. INBOX PROCESSING
# ============================================================================
echo -e "${BLUE}## Inbox Processing${NC}"

INBOX_COUNT=$(find "$VAULT_DIR/inbox" -name "*.md" -type f ! -name ".gitkeep" | wc -l)

if [ "$INBOX_COUNT" -eq 0 ]; then
    echo -e "${GREEN}✅ Inbox is clean (0 items)${NC}"
else
    echo -e "${YELLOW}📥 ${INBOX_COUNT} item(s) in inbox:${NC}"
    find "$VAULT_DIR/inbox" -name "*.md" -type f ! -name ".gitkeep" | while read file; do
        basename "$file"
    done
fi
echo ""

# ============================================================================
# 3. ORPHAN CHECK
# ============================================================================
echo -e "${BLUE}## Orphan Check (notes with no incoming links)${NC}"

# Build a list of all wikilinks in the vault
ALL_LINKS=$(grep -rhoE '\[\[([^\]]+)\]\]' "$VAULT_DIR" --include="*.md" 2>/dev/null | sed 's/\[\[//;s/\]\]//' | sort -u)

# Check projects/
PROJECT_ORPHANS=()
for file in "$VAULT_DIR"/projects/*.md; do
    [ -f "$file" ] || continue
    basename_no_ext=$(basename "$file" .md)
    # Check if this note is referenced anywhere
    if ! echo "$ALL_LINKS" | grep -qF "$basename_no_ext"; then
        PROJECT_ORPHANS+=("$(basename "$file")")
    fi
done

# Check areas/
AREA_ORPHANS=()
for file in "$VAULT_DIR"/areas/*.md; do
    [ -f "$file" ] || continue
    [ "$(basename "$file")" = ".gitkeep" ] && continue
    basename_no_ext=$(basename "$file" .md)
    if ! echo "$ALL_LINKS" | grep -qF "$basename_no_ext"; then
        AREA_ORPHANS+=("$(basename "$file")")
    fi
done

# Check ideas/
IDEA_ORPHANS=()
for file in "$VAULT_DIR"/ideas/*.md; do
    [ -f "$file" ] || continue
    [ "$(basename "$file")" = ".gitkeep" ] && continue
    basename_no_ext=$(basename "$file" .md)
    if ! echo "$ALL_LINKS" | grep -qF "$basename_no_ext"; then
        IDEA_ORPHANS+=("$(basename "$file")")
    fi
done

# Check people/
PEOPLE_ORPHANS=()
for file in "$VAULT_DIR"/people/*.md; do
    [ -f "$file" ] || continue
    [ "$(basename "$file")" = ".gitkeep" ] && continue
    basename_no_ext=$(basename "$file" .md)
    if ! echo "$ALL_LINKS" | grep -qF "$basename_no_ext"; then
        PEOPLE_ORPHANS+=("$(basename "$file")")
    fi
done

TOTAL_ORPHANS=$((${#PROJECT_ORPHANS[@]} + ${#AREA_ORPHANS[@]} + ${#IDEA_ORPHANS[@]} + ${#PEOPLE_ORPHANS[@]}))

if [ "$TOTAL_ORPHANS" -eq 0 ]; then
    echo -e "${GREEN}✅ No orphans found${NC}"
else
    echo -e "${YELLOW}⚠️  ${TOTAL_ORPHANS} orphan(s) found:${NC}"
    
    if [ ${#PROJECT_ORPHANS[@]} -gt 0 ]; then
        echo ""
        echo "Projects:"
        printf '  - %s\n' "${PROJECT_ORPHANS[@]}"
    fi
    
    if [ ${#IDEA_ORPHANS[@]} -gt 0 ]; then
        echo ""
        echo "Ideas:"
        printf '  - %s\n' "${${IDEA_ORPHANS[@]}[@]}"
    fi
    
    if [ ${#PEOPLE_ORPHANS[@]} -gt 0 ]; then
        echo ""
        echo "People:"
        printf '  - %s\n' "${PEOPLE_ORPHANS[@]}"
    fi
fi
echo ""

# ============================================================================
# 4. STALE PROJECT DETECTION
# ============================================================================
echo -e "${BLUE}## Stale Projects (30+ days without update)${NC}"

STALE_COUNT=0
STALE_PROJECTS=()

while IFS= read -r file; do
    [ -f "$file" ] || continue
    
    # Get last modification time
    if [ "$(uname)" = "Darwin" ]; then
        # macOS
        mod_date=$(stat -f "%Sm" -t "%Y-%m-%d" "$file")
    else
        # Linux
        mod_date=$(stat -c "%y" "$file" | cut -d' ' -f1)
    fi
    
    # Compare dates
    if [[ "$mod_date" < "$STALE_THRESHOLD" ]]; then
        STALE_COUNT=$((STALE_COUNT + 1))
        STALE_PROJECTS+=("$(basename "$file") (last: $mod_date)")
    fi
done < <(find "$VAULT_DIR/projects" -name "*.md" -type f ! -name ".gitkeep")

if [ "$STALE_COUNT" -eq 0 ]; then
    echo -e "${GREEN}✅ No stale projects${NC}"
else
    echo -e "${YELLOW}⏰ ${STALE_COUNT} stale project(s):${NC}"
    printf '  - %s\n' "${STALE_PROJECTS[@]}" | head -15
    [ "$STALE_COUNT" -gt 15 ] && echo "  ... and $((STALE_COUNT - 15)) more"
fi
echo ""

# ============================================================================
# 5. FRONTMATTER VALIDATION
# ============================================================================
echo -e "${BLUE}## Frontmatter Validation${NC}"

MISSING_TYPE=0
MISSING_SUMMARY=0
MISSING_STATUS=0

# Check a sample of recent files
while IFS= read -r file; do
    [ -f "$file" ] || continue
    
    # Check for YAML frontmatter
    if ! head -1 "$file" | grep -q "^---"; then
        continue
    fi
    
    # Extract frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | tail -n +2 | head -n -1)
    
    # Check type
    if ! echo "$frontmatter" | grep -qE "^type:"; then
        MISSING_TYPE=$((MISSING_TYPE + 1))
    fi
    
    # Check summary
    if ! echo "$frontmatter" | grep -qE "^summary:"; then
        MISSING_SUMMARY=$((MISSING_SUMMARY + 1))
    fi
    
    # Check status for actionable notes
    if echo "$frontmatter" | grep -qE "^type:\s*(project|idea)"; then
        if ! echo "$frontmatter" | grep -qE "^status:"; then
            MISSING_STATUS=$((MISSING_STATUS + 1))
        fi
    fi
done < <(find "$VAULT_DIR" -name "*.md" -type f -mtime -7 2>/dev/null | head -50)

if [ "$MISSING_TYPE" -eq 0 ] && [ "$MISSING_SUMMARY" -eq 0 ] && [ "$MISSING_STATUS" -eq 0 ]; then
    echo -e "${GREEN}✅ Recent notes have proper frontmatter${NC}"
else
    [ "$MISSING_TYPE" -gt 0 ] && echo -e "${YELLOW}⚠️  ${MISSING_TYPE} note(s) missing 'type'${NC}"
    [ "$MISSING_SUMMARY" -gt 0 ] && echo -e "${YELLOW}⚠️  ${MISSING_SUMMARY} note(s) missing 'summary'${NC}"
    [ "$MISSING_STATUS" -gt 0 ] && echo -e "${YELLOW}⚠️  ${MISSING_STATUS} project/idea note(s) missing 'status'${NC}"
fi
echo ""

# ============================================================================
# SUMMARY
# ============================================================================
echo -e "${BLUE}## Summary${NC}"
echo "- Inbox items: $INBOX_COUNT"
echo "- Orphan notes: $TOTAL_ORPHANS"
echo "- Stale projects: $STALE_COUNT"
echo "- Missing type: $MISSING_TYPE"
echo "- Missing summary: $MISSING_SUMMARY"
echo ""
echo -e "${GREEN}🌿 Gardening complete!${NC}"
