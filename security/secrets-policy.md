# Secrets Policy

**Version:** 1.0
**Date:** March 28, 2026

## Rules

1. **Never commit secrets to Git.** This includes API keys, passwords, tokens, private keys, connection strings, and any credential material.

2. **Use `.env` files for local development.** All `.env` files must be in `.gitignore`.

3. **Use GitHub Secrets (or equivalent vault) for CI/CD.** Never hardcode secrets in workflow files.

4. **Provide `.env.example` files** with placeholder values so developers know which variables are required.

5. **Rotate compromised credentials immediately.** If a secret is accidentally committed, consider it compromised even after removal (Git history retains it).

6. **Pre-commit hooks** should scan for common secret patterns before allowing commits.

## Common Patterns to Detect

```
AKIA[A-Z0-9]{16}          # AWS Access Key
sk-[a-zA-Z0-9]{48}        # OpenAI/Anthropic API Key
ghp_[a-zA-Z0-9]{36}       # GitHub Personal Access Token
-----BEGIN.*PRIVATE KEY    # Private keys
password\s*=\s*[^\s]+     # Hardcoded passwords
Bearer\s+[a-zA-Z0-9._-]+  # Bearer tokens
```
