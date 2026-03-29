# Cross-Machine Setup Instructions

**Version:** 1.0
**Date:** March 28, 2026

## Prerequisites (All Machines)

Before running setup on any machine, ensure:

1. **macOS** with Apple Silicon (M-series chip)
2. **Homebrew** installed: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. **Git** installed and configured:
   ```bash
   brew install git
   git config --global user.name "Mike May"
   git config --global user.email "mikemaycga@me.com"
   ```
4. **GitHub CLI** installed and authenticated:
   ```bash
   brew install gh
   gh auth login
   ```
5. **Claude Code** installed (follow Anthropic's installation guide)
6. **SSH key** configured for GitHub:
   ```bash
   ssh-keygen -t ed25519 -C "mikemaycga@me.com"
   gh ssh-key add ~/.ssh/id_ed25519.pub
   ```

---

## Machine 1: Primary Mac (Current Machine)

This is the initial setup that creates the Git repository and GitHub remote.

### Step 1: Copy the framework to its permanent home

The framework files are currently in the folder you selected for this Cowork session. Copy them to their permanent location:

```bash
cp -R "/path/to/Design Mike's agentic development world/agentic-dev" ~/agentic-dev
```

### Step 2: Run the setup script

```bash
cd ~/agentic-dev
./setup.sh primary
```

This will:
- Initialize a Git repository in `~/agentic-dev/`
- Create a private GitHub repository named `agentic-dev`
- Push the initial commit
- Create symlinks: `~/.claude/CLAUDE.md`, `~/.claude/agents/`, `~/.claude/skills/`
- Set up the iCloud secondary sync location at `~/agentic-cowork`

### Step 3: Verify

```bash
# Check symlinks
ls -la ~/.claude/CLAUDE.md
ls -la ~/.claude/agents
ls -la ~/.claude/skills

# Check Git remote
cd ~/agentic-dev && git remote -v

# Check Claude Code sees the agents
claude --print-agents  # or start a Claude Code session and ask "what agents are available?"
```

---

## Machine 2: MacBook Pro

### Step 1: Ensure prerequisites are installed

Run through the Prerequisites section above.

### Step 2: Clone and set up

```bash
gh repo clone agentic-dev ~/agentic-dev
cd ~/agentic-dev
./setup.sh secondary
```

This will:
- Clone the framework from GitHub to `~/agentic-dev/`
- Create the same symlinks as the primary machine
- Set up iCloud secondary sync location

### Step 3: Verify

Same verification steps as Machine 1 (Step 3 above).

---

## Machine 3: Mac Mini

Identical process to Machine 2 (MacBook Pro). Run:

```bash
gh repo clone agentic-dev ~/agentic-dev
cd ~/agentic-dev
./setup.sh secondary
```

---

## Day-to-Day Workflow

### Starting work on any machine

```bash
cd ~/agentic-dev && git pull origin main
```

This ensures you have the latest framework changes (including any learnings.md updates from weekly pruning, new standards, or agent refinements).

### After making framework changes

```bash
cd ~/agentic-dev
git add -A
git commit -m "type(scope): description

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
git push origin main
```

### On the other machines (to pick up changes)

```bash
cd ~/agentic-dev && git pull origin main
```

Symlinks automatically point to the updated files — no additional steps needed.

### Project repositories (separate from framework)

Individual projects have their own Git repos. The framework provides global agents and skills via symlinks. Projects can also have project-specific agents and skills in their own `.claude/` directories.

```bash
# Example: clone a project on a new machine
git clone git@github.com:your-org/project-name.git ~/projects/project-name

# The project automatically gets:
# - Global agents/skills via ~/.claude/ symlinks
# - Project-specific agents/skills from its own .claude/ directory
```

---

## What Syncs Where

| Content | Sync Method | Location |
|---------|------------|----------|
| Framework (agents, skills, standards) | Git | `~/agentic-dev/` |
| Project code | Git (per-project repos) | `~/projects/[project-name]/` |
| Cowork outputs (docs, presentations) | iCloud | `~/agentic-cowork/` |
| Large media files | iCloud | `~/agentic-cowork/` |
| Machine-specific settings | Not synced | `CLAUDE.local.md`, `settings.local.json` |
| Client-confidential deliverables | Git only | Project repos (never iCloud) |

## What Does NOT Sync

- `CLAUDE.local.md` — Machine-specific overrides (gitignored)
- `settings.local.json` — Machine-specific Claude settings (gitignored)
- `.env` files — Environment variables with secrets (gitignored)
- Homebrew installations — Install independently on each machine
- Claude Code installation — Install independently on each machine

---

## Troubleshooting

**Symlinks broken after Git pull:**
```bash
# Re-run the symlink creation
cd ~/agentic-dev && ./setup.sh secondary
```

**Claude Code doesn't see agents/skills:**
```bash
# Verify symlinks point to correct targets
ls -la ~/.claude/agents/
# Should show: agents -> /Users/mmay/agentic-dev/agents
```

**Git conflicts in learnings.md (self-improving skills):**
The weekly pruning process runs on one machine. If you edit learnings on multiple machines without pulling first, merge the changes manually — learnings.md files are small enough that conflicts are trivially resolvable.

**iCloud sync conflicts:**
If you see `.icloud` placeholder files, open the file in Finder to trigger download. iCloud Drive optimization can delay file availability.
