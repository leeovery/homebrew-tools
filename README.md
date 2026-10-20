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

# Casks:
brew install --cask leeovery/tools/spaceman-ruittenb
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

| Cask | Description | Repository |
|------|-------------|------------|
| `spaceman-ruittenb` | Spaceman, the menu-bar Spaces app: the ruittenb fork (bundle id `dev.ruittenb.Spaceman`), not homebrew/cask's `spaceman` | [ruittenb/Spaceman](https://github.com/ruittenb/Spaceman) |

## Updating

```bash
brew upgrade tick
brew upgrade portal
brew upgrade switchboard
brew upgrade stitch
brew upgrade bash-toolkit
```

Formulas auto-update via GitHub Actions when new releases are published. The Spaceman cask is updated by hand; the app updates itself through Sparkle.
