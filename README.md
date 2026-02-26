# Homebrew Tools

Homebrew tap for personal CLI tools.

## Installation

```bash
# Public tools (no token required):
brew install leeovery/tools/tick
brew install leeovery/tools/portal

# Private tools require a GitHub Personal Access Token with 'repo' scope:
#   https://github.com/settings/tokens
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

brew install leeovery/tools/stitch
brew install leeovery/tools/bash-toolkit
```

## Available Formulas

| Formula | Description | Repository | Auth Required |
|---------|-------------|------------|---------------|
| `tick` | Priority-based task scheduling CLI | [leeovery/tick](https://github.com/leeovery/tick) | No (public) |
| `portal` | Interactive session picker for tmux | [leeovery/portal](https://github.com/leeovery/portal) | No (public) |
| `stitch` | Multi-strategy release management CLI | [leeovery/stitch](https://github.com/leeovery/stitch) | Yes |
| `bash-toolkit` | Bash library for terminal messaging and UI | [leeovery/bash-toolkit](https://github.com/leeovery/bash-toolkit) | Yes |

## Updating

```bash
brew upgrade tick
brew upgrade portal
brew upgrade stitch
brew upgrade bash-toolkit
```

Formulas auto-update via GitHub Actions when new releases are published.
