#!/bin/bash
# ============================================================================
# Agentic Development Environment — Machine Setup Script
# ============================================================================
# Usage: ./setup.sh [primary|secondary]
#
# - primary:   First machine setup — initializes Git repo, creates GitHub remote
# - secondary: Additional machines — clones from GitHub, creates symlinks
#
# Prerequisites:
#   - macOS with Apple Silicon
#   - Git installed and configured (git config user.name / user.email)
#   - GitHub CLI installed and authenticated (brew install gh && gh auth login)
#   - Claude Code installed
# ============================================================================

set -euo pipefail

FRAMEWORK_DIR="$HOME/agentic-dev"
CLAUDE_DIR="$HOME/.claude"
ICLOUD_BASE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
ICLOUD_COWORK="$ICLOUD_BASE/agentic-cowork"
GITHUB_REPO="agentic-dev"  # Change this if using a different repo name

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ============================================================================
# Pre-flight checks
# ============================================================================
preflight_checks() {
    log_info "Running pre-flight checks..."

    # Check Git
    if ! command -v git &> /dev/null; then
        log_error "Git is not installed. Install with: brew install git"
        exit 1
    fi
    log_info "Git: $(git --version)"

    # Check GitHub CLI
    if ! command -v gh &> /dev/null; then
        log_error "GitHub CLI is not installed. Install with: brew install gh"
        exit 1
    fi

    # Check gh auth
    if ! gh auth status &> /dev/null; then
        log_error "GitHub CLI is not authenticated. Run: gh auth login"
        exit 1
    fi
    log_info "GitHub CLI: authenticated"

    # Check Claude Code
    if command -v claude &> /dev/null; then
        log_info "Claude Code: installed"
    else
        log_warn "Claude Code not found in PATH. Install before using agents/skills."
    fi

    log_info "Pre-flight checks passed."
}

# ============================================================================
# Primary machine setup
# ============================================================================
setup_primary() {
    log_info "=== PRIMARY MACHINE SETUP ==="

    # Check if framework dir already exists
    if [ -d "$FRAMEWORK_DIR" ]; then
        log_warn "$FRAMEWORK_DIR already exists."
        read -p "Overwrite? (y/N): " confirm
        if [ "$confirm" != "y" ]; then
            log_info "Aborted."
            exit 0
        fi
    fi

    # Step 1: Copy framework files to ~/agentic-dev/
    log_info "Step 1: Installing framework to $FRAMEWORK_DIR..."
    if [ -d "$FRAMEWORK_DIR" ]; then
        # Preserve any existing .git directory
        if [ -d "$FRAMEWORK_DIR/.git" ]; then
            log_info "Preserving existing .git directory..."
            mv "$FRAMEWORK_DIR/.git" /tmp/agentic-dev-git-backup
        fi
    fi

    # Copy the framework (this script should be run from within the agentic-dev directory)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ "$SCRIPT_DIR" != "$FRAMEWORK_DIR" ]; then
        mkdir -p "$FRAMEWORK_DIR"
        cp -R "$SCRIPT_DIR"/* "$FRAMEWORK_DIR/"
        cp "$SCRIPT_DIR"/.gitignore "$FRAMEWORK_DIR/" 2>/dev/null || true
    fi

    # Restore .git if it existed
    if [ -d /tmp/agentic-dev-git-backup ]; then
        mv /tmp/agentic-dev-git-backup "$FRAMEWORK_DIR/.git"
    fi

    log_info "Framework files installed."

    # Step 2: Initialize Git repo
    log_info "Step 2: Initializing Git repository..."
    cd "$FRAMEWORK_DIR"

    if [ ! -d .git ]; then
        git init
        git add -A
        git commit -m "feat: initialize agentic development environment framework

Framework v1.0 based on architecture document v1.6.
Includes: 8 core agents, 4 specialists, 6 skills, 3 project templates,
3 security profiles, 6 standards documents, knowledge library structure.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
        log_info "Git repository initialized with initial commit."
    else
        log_info "Git repository already exists. Skipping init."
    fi

    # Step 3: Create GitHub remote
    log_info "Step 3: Creating GitHub remote repository..."
    if ! gh repo view "$GITHUB_REPO" &> /dev/null; then
        gh repo create "$GITHUB_REPO" --private --source=. --remote=origin --push
        log_info "GitHub repository created and pushed."
    else
        log_warn "GitHub repository '$GITHUB_REPO' already exists. Setting remote..."
        git remote add origin "$(gh repo view "$GITHUB_REPO" --json sshUrl -q .sshUrl)" 2>/dev/null || true
        git push -u origin main 2>/dev/null || git push -u origin master
    fi

    # Step 4: Create symlinks for Claude Code discovery
    log_info "Step 4: Creating symlinks for Claude Code..."
    create_symlinks

    # Step 5: Set up iCloud secondary sync location
    log_info "Step 5: Setting up iCloud secondary sync location..."
    setup_icloud

    # Step 6: Verify
    log_info "Step 6: Verifying installation..."
    verify_installation

    echo ""
    log_info "=== PRIMARY MACHINE SETUP COMPLETE ==="
    echo ""
    echo "Next steps:"
    echo "  1. Run './setup.sh secondary' on your MacBook Pro and Mac Mini"
    echo "  2. Or manually: git clone, then run this script with 'secondary' flag"
    echo ""
}

# ============================================================================
# Secondary machine setup
# ============================================================================
setup_secondary() {
    log_info "=== SECONDARY MACHINE SETUP ==="

    # Step 1: Clone from GitHub
    log_info "Step 1: Cloning framework from GitHub..."
    if [ -d "$FRAMEWORK_DIR" ]; then
        log_warn "$FRAMEWORK_DIR already exists. Pulling latest..."
        cd "$FRAMEWORK_DIR"
        git pull origin main 2>/dev/null || git pull origin master
    else
        gh repo clone "$GITHUB_REPO" "$FRAMEWORK_DIR"
        cd "$FRAMEWORK_DIR"
    fi
    log_info "Framework cloned/updated."

    # Step 2: Create symlinks
    log_info "Step 2: Creating symlinks for Claude Code..."
    create_symlinks

    # Step 3: Set up iCloud secondary sync
    log_info "Step 3: Setting up iCloud secondary sync location..."
    setup_icloud

    # Step 4: Verify
    log_info "Step 4: Verifying installation..."
    verify_installation

    echo ""
    log_info "=== SECONDARY MACHINE SETUP COMPLETE ==="
    echo ""
}

# ============================================================================
# Shared functions
# ============================================================================
create_symlinks() {
    mkdir -p "$CLAUDE_DIR"

    # Back up existing files/symlinks
    for item in CLAUDE.md agents skills; do
        if [ -e "$CLAUDE_DIR/$item" ] && [ ! -L "$CLAUDE_DIR/$item" ]; then
            log_warn "Backing up existing $CLAUDE_DIR/$item to $CLAUDE_DIR/$item.backup"
            mv "$CLAUDE_DIR/$item" "$CLAUDE_DIR/$item.backup"
        fi
    done

    # Create symlinks
    ln -sf "$FRAMEWORK_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    ln -sf "$FRAMEWORK_DIR/agents" "$CLAUDE_DIR/agents"
    ln -sf "$FRAMEWORK_DIR/skills" "$CLAUDE_DIR/skills"

    # Create rules symlink if rules directory exists
    if [ -d "$FRAMEWORK_DIR/rules" ]; then
        ln -sf "$FRAMEWORK_DIR/rules" "$CLAUDE_DIR/rules"
    fi

    log_info "Symlinks created:"
    log_info "  ~/.claude/CLAUDE.md → ~/agentic-dev/CLAUDE.md"
    log_info "  ~/.claude/agents/   → ~/agentic-dev/agents/"
    log_info "  ~/.claude/skills/   → ~/agentic-dev/skills/"
}

setup_icloud() {
    if [ -d "$ICLOUD_BASE" ]; then
        mkdir -p "$ICLOUD_COWORK"
        # Create convenience symlink
        ln -sf "$ICLOUD_COWORK" "$HOME/agentic-cowork"
        log_info "iCloud secondary sync location: ~/agentic-cowork"
    else
        log_warn "iCloud Drive not found at expected location. Skipping iCloud setup."
        log_warn "If iCloud Drive is enabled, it may be at a different path."
    fi
}

verify_installation() {
    local errors=0

    # Check framework directory
    if [ -d "$FRAMEWORK_DIR" ]; then
        log_info "✓ Framework directory exists: $FRAMEWORK_DIR"
    else
        log_error "✗ Framework directory missing: $FRAMEWORK_DIR"
        ((errors++))
    fi

    # Check symlinks
    if [ -L "$CLAUDE_DIR/CLAUDE.md" ]; then
        log_info "✓ CLAUDE.md symlink exists"
    else
        log_error "✗ CLAUDE.md symlink missing"
        ((errors++))
    fi

    if [ -L "$CLAUDE_DIR/agents" ]; then
        log_info "✓ agents/ symlink exists"
    else
        log_error "✗ agents/ symlink missing"
        ((errors++))
    fi

    if [ -L "$CLAUDE_DIR/skills" ]; then
        log_info "✓ skills/ symlink exists"
    else
        log_error "✗ skills/ symlink missing"
        ((errors++))
    fi

    # Check critical files
    for file in CLAUDE.md .gitignore agents/orchestrator/larry.md skills/fix-issue/SKILL.md security/profiles/professional-standard.md; do
        if [ -f "$FRAMEWORK_DIR/$file" ]; then
            log_info "✓ $file"
        else
            log_error "✗ Missing: $file"
            ((errors++))
        fi
    done

    # Check Git
    if [ -d "$FRAMEWORK_DIR/.git" ]; then
        log_info "✓ Git repository initialized"
    else
        log_error "✗ Git repository not initialized"
        ((errors++))
    fi

    if [ $errors -eq 0 ]; then
        log_info "All verification checks passed."
    else
        log_error "$errors verification check(s) failed."
    fi
}

# ============================================================================
# Main
# ============================================================================
MODE="${1:-}"

if [ -z "$MODE" ]; then
    echo "Usage: ./setup.sh [primary|secondary]"
    echo ""
    echo "  primary    - First machine: init Git repo, create GitHub remote, create symlinks"
    echo "  secondary  - Additional machines: clone from GitHub, create symlinks"
    exit 1
fi

preflight_checks

case "$MODE" in
    primary)
        setup_primary
        ;;
    secondary)
        setup_secondary
        ;;
    *)
        log_error "Unknown mode: $MODE. Use 'primary' or 'secondary'."
        exit 1
        ;;
esac
