#!/bin/bash
# sync-to-live.sh — Sync Cowork workspace to live framework and push to GitHub
# Handles both public framework repo and private knowledge library repo
# Usage: bash ~/agentic-dev/sync-to-live.sh

set -e

SOURCE="$HOME/Claude/Claude CoWork Projects/Design Mike's agentic development world/agentic-dev"
TARGET="$HOME/agentic-dev"
KNOWLEDGE="$TARGET/knowledge-library"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# ── 1. Sync framework directories (public repo) ──
echo -e "${YELLOW}[SYNC] Copying framework files from Cowork workspace...${NC}"
for dir in agents framework docs security skills templates; do
    if [ -d "$SOURCE/$dir" ]; then
        cp -R "$SOURCE/$dir" "$TARGET/"
        echo -e "${GREEN}  ✓ $dir${NC}"
    fi
done

for file in mkdocs.yml .gitignore CLAUDE.md README.md SETUP-INSTRUCTIONS.md; do
    if [ -f "$SOURCE/$file" ]; then
        cp "$SOURCE/$file" "$TARGET/"
        echo -e "${GREEN}  ✓ $file${NC}"
    fi
done

# ── 2. Sync knowledge library (private repo) ──
if [ -d "$SOURCE/knowledge-library" ] && [ -d "$KNOWLEDGE/.git" ]; then
    echo ""
    echo -e "${YELLOW}[SYNC] Copying knowledge library files...${NC}"
    # Sync contents without overwriting .git directory
    rsync -a --exclude='.git' "$SOURCE/knowledge-library/" "$KNOWLEDGE/"
    echo -e "${GREEN}  ✓ knowledge-library${NC}"

    echo ""
    echo -e "${YELLOW}[KNOWLEDGE] Staging and pushing private repo...${NC}"
    cd "$KNOWLEDGE"
    git add -A
    git diff --cached --quiet && echo "  Nothing to commit in knowledge-library" || {
        git commit -m "sync: update knowledge library $(date +%Y-%m-%d)

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
        git push
        echo -e "${GREEN}  ✓ knowledge-library pushed to private repo${NC}"
    }
elif [ -d "$SOURCE/knowledge-library" ]; then
    echo ""
    echo -e "${RED}[WARN] knowledge-library exists in Cowork but no private repo found at $KNOWLEDGE${NC}"
    echo "  Run: cd ~/agentic-dev/knowledge-library && git init && git remote add origin git@github.com:mikemaycga/agentic-dev-knowledge.git"
fi

# ── 3. Commit and push public framework repo ──
echo ""
echo -e "${YELLOW}[GIT] Staging public framework changes...${NC}"
cd "$TARGET"
git add -A
echo ""
git status --short

echo ""
echo -e "${YELLOW}[GIT] Committing...${NC}"
git diff --cached --quiet && echo "  Nothing to commit in framework" || {
    git commit -m "sync: update framework from Cowork session $(date +%Y-%m-%d)

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
    git push
    echo -e "${GREEN}  ✓ framework pushed to public repo${NC}"
}

# ── 4. Deploy docs site ──
echo ""
echo -e "${YELLOW}[DOCS] Deploying to GitHub Pages...${NC}"
mkdocs gh-deploy

echo ""
echo -e "${GREEN}[DONE] Sync complete.${NC}"
echo "  Public framework: https://github.com/mikemaycga/agentic-dev"
echo "  Private knowledge: https://github.com/mikemaycga/agentic-dev-knowledge"
echo "  Docs site: https://mikemaycga.github.io/agentic-dev/"
