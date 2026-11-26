# Homebrew Tools

Homebrew tap for personal CLI tools.

## Installation

```bash
# Public tools (no token required):
brew install leeovery/tools/tick
brew install leeovery/tools/portal
brew install leeovery/tools/switchboard
brew install leeovery/tools/kit
brew install --cask leeovery/tools/sitrep
brew install --cask leeovery/tools/spaceman

# Private tools require a GitHub Personal Access Token with 'repo' scope:
#   https://github.com/settings/tokens
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

brew install leeovery/tools/stitch
brew install leeovery/tools/stitch-bash
brew install leeovery/tools/bash-toolkit
```

## Available Formulas

| Formula | Description | Repository | Auth Required |
|---------|-------------|------------|---------------|
| `tick` | Priority-based task scheduling CLI | [leeovery/tick](https://github.com/leeovery/tick) | No (public) |
| `portal` | Interactive session picker for tmux | [leeovery/portal](https://github.com/leeovery/portal) | No (public) |
| `switchboard` | Spread Claude Code sessions across several Claude subscriptions | [leeovery/switchboard](https://github.com/leeovery/switchboard) | No (public) |
| `kit` | Set up a Mac from a config repository, and keep it that way | [leeovery/kit](https://github.com/leeovery/kit) | No (public) |
| `stitch` | The shipping tool for you and your agents | [leeovery/stitch](https://github.com/leeovery/stitch) | Yes |
| `stitch-bash` | The bash Stitch, run as `stitch-bash`, for apps still on the old platform | [leeovery/stitch-bash](https://github.com/leeovery/stitch-bash) | Yes |
| `bash-toolkit` | Bash library for terminal messaging and UI | [leeovery/bash-toolkit](https://github.com/leeovery/bash-toolkit) | Yes |

## Available Casks

| Cask | Description | Repository | Auth Required |
|------|-------------|------------|---------------|
| `sitrep` | SitRep, the menu bar board for Claude Code sessions, carrying the sitrep plugin (Apple silicon, macOS 14+) | [leeovery/sitrep](https://github.com/leeovery/sitrep) | No (public) |
| `spaceman` | Spaceman, spaces in the menu bar, named in Mission Control (universal, macOS 26+) | [leeovery/spaceman](https://github.com/leeovery/spaceman) | No (public) |

## Updating

```bash
brew upgrade tick
brew upgrade portal
brew upgrade switchboard
brew upgrade stitch
brew upgrade stitch-bash
brew upgrade bash-toolkit
brew upgrade --cask sitrep
brew upgrade --cask spaceman
```

Formulas and casks auto-update via GitHub Actions when new releases are published.

Two workflows do it. `update-formula.yml` edits a formula's or cask's version and sums in place, per tool. `write-formula.yml` writes a formula or cask that press (leeovery/press) sends whole, rendered from the project's own template: it knows no tool, and refuses anything that isn't a well-formed formula or cask for the name it claims. Its runs go side by side, never cancelled: each writes onto main's latest tip, tries again when another's push lands first, and never takes a file back a version. Its script's tests run with:

```bash
scripts/write-formula-test
```
