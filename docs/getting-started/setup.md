# Setup Guide

## Prerequisites

- macOS with Apple Silicon (M-series)
- Git installed and configured
- GitHub CLI installed and authenticated (`brew install gh && gh auth login`)
- Claude Code installed
- SSH key configured for GitHub

## Primary Machine Setup

```bash
# Copy framework to permanent location
cp -R /path/to/agentic-dev ~/agentic-dev

# Run setup script
cd ~/agentic-dev && ./setup.sh primary
```

The setup script will:

1. Initialize a Git repository
2. Create a private GitHub remote
3. Push the initial commit
4. Create symlinks: `~/.claude/CLAUDE.md`, `~/.claude/agents/`, `~/.claude/skills/`
5. Set up iCloud secondary sync at `~/agentic-cowork`

## Verify Installation

```bash
ls -la ~/.claude/CLAUDE.md    # Should be a symlink
ls -la ~/.claude/agents       # Should be a symlink
ls -la ~/.claude/skills       # Should be a symlink
cd ~/agentic-dev && git remote -v  # Should show GitHub remote
```

## Additional Machines

See [Cross-Machine Sync](cross-machine-sync.md) for setting up your MacBook Pro and Mac Mini.
