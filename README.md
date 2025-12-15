# Homebrew Tools

Homebrew tap for personal CLI tools.

## Installation

**Authentication Required:** Private repositories require a GitHub Personal Access Token.

```bash
# 1. Create a GitHub Personal Access Token with 'repo' scope:
#    https://github.com/settings/tokens

# 2. Set the token:
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

# 3. Install:
brew install leeovery/tools/stitch
brew install leeovery/tools/bash-toolkit
```

## Available Formulas

| Formula | Description | Repository |
|---------|-------------|------------|
| `stitch` | Multi-strategy release management CLI | [leeovery/stitch](https://github.com/leeovery/stitch) |
| `bash-toolkit` | Bash library for terminal messaging and UI | [leeovery/bash-toolkit](https://github.com/leeovery/bash-toolkit) |

## Updating

```bash
brew upgrade stitch
brew upgrade bash-toolkit
```

Formulas auto-update via GitHub Actions when new releases are published.
