# Homebrew Tools

Homebrew tap for personal CLI tools.

## Installation

```bash
# Public tools (no token required):
brew install leeovery/tools/tick
brew install leeovery/tools/portal
brew install leeovery/tools/switchboard

# Private tools require a GitHub Personal Access Token with 'repo' scope:
#   https://github.com/settings/tokens
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

brew install leeovery/tools/stitch
brew install leeovery/tools/bash-toolkit

# Casks (private, so the same token):
brew install --cask leeovery/tools/sitrep
```

## Available Formulas

| Formula | Description | Repository | Auth Required |
|---------|-------------|------------|---------------|
| `tick` | Priority-based task scheduling CLI | [leeovery/tick](https://github.com/leeovery/tick) | No (public) |
| `portal` | Interactive session picker for tmux | [leeovery/portal](https://github.com/leeovery/portal) | No (public) |
| `switchboard` | Spread Claude Code sessions across several Claude subscriptions | [leeovery/switchboard](https://github.com/leeovery/switchboard) | No (public) |
| `stitch` | Multi-strategy release management CLI | [leeovery/stitch](https://github.com/leeovery/stitch) | Yes |
| `bash-toolkit` | Bash library for terminal messaging and UI | [leeovery/bash-toolkit](https://github.com/leeovery/bash-toolkit) | Yes |

## Available Casks

| Cask | Description | Repository | Auth Required |
|------|-------------|------------|---------------|
| `sitrep` | SitRep, the menu bar board for Claude Code sessions, carrying the sitrep plugin (Apple silicon, macOS 14+) | [leeovery/sitrep](https://github.com/leeovery/sitrep) | Yes |

## Updating

```bash
brew upgrade tick
brew upgrade portal
brew upgrade switchboard
brew upgrade stitch
brew upgrade bash-toolkit
brew upgrade --cask sitrep
```

Formulas and casks auto-update via GitHub Actions when new releases are published.
