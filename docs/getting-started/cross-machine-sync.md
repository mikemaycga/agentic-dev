# Cross-Machine Sync

## Additional Machine Setup

On each additional Mac (MacBook Pro, Mac Mini):

```bash
gh repo clone agentic-dev ~/agentic-dev
cd ~/agentic-dev && ./setup.sh secondary
```

This clones from GitHub, creates identical symlinks, and verifies the installation.

## Day-to-Day Workflow

### Starting work on any machine

```bash
cd ~/agentic-dev && git pull origin master
```

### After making framework changes

```bash
cd ~/agentic-dev
git add -A
git commit -m "type(scope): description

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"
git push origin master
```

### On other machines

```bash
cd ~/agentic-dev && git pull origin master
```

Symlinks automatically resolve to updated files — no additional steps needed.

## What Does NOT Sync

- `CLAUDE.local.md` — Machine-specific overrides (gitignored)
- `settings.local.json` — Machine-specific Claude settings (gitignored)
- `.env` files — Environment variables with secrets (gitignored)
- Homebrew and Claude Code installations — Install independently per machine
