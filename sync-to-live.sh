#!/bin/bash
# sync-to-live.sh — Sync Cowork workspace to live framework and push to GitHub
# Usage: bash ~/agentic-dev/sync-to-live.sh

set -e

SOURCE="$HOME/Claude/Claude CoWork Projects/Design Mike's agentic development world/agentic-dev"
TARGET="$HOME/agentic-dev"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}[SYNC] Copying from Cowork workspace to live framework...${NC}"

# Sync all framework directories
for dir in agents framework docs knowledge-library security skills templates; do
    if [ -d "$SOURCE/$dir" ]; then
        cp -R "$SOURCE/$dir" "$TARGET/"
        echo -e "${GREEN}  ✓ $dir${NC}"
    fi
done

# Sync root config files
for file in mkdocs.yml .gitignore CLAUDE.md README.md SETUP-INSTRUCTIONS.md; do
    if [ -f "$SOURCE/$file" ]; then
        cp "$SOURCE/$file" "$TARGET/"
        echo -e "${GREEN}  ✓ $file${NC}"
    fi
done

echo ""
echo -e "${YELLOW}[GIT] Staging changes...${NC}"
cd "$TARGET"
git add -A
echo ""
git status --short

echo ""
echo -e "${YELLOW}[GIT] Committing...${NC}"
git commit -m "sync: update framework from Cowork session $(date +%Y-%m-%d)

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>" || echo "Nothing to commit"

echo ""
echo -e "${YELLOW}[GIT] Pushing to GitHub...${NC}"
git push

echo ""
echo -e "${YELLOW}[DOCS] Deploying to GitHub Pages...${NC}"
mkdocs gh-deploy

echo ""
echo -e "${GREEN}[DONE] Sync complete.${NC}"
echo "  Live framework: $TARGET"
echo "  GitHub: https://github.com/mikemaycga/agentic-dev"
echo "  Docs: https://mikemaycga.github.io/agentic-dev/"
