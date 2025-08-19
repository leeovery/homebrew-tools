# leeovery Homebrew Tools

This repository contains Homebrew formulas for leeovery developer tools.

## Installation

**Authentication Required:** Since these are private repositories, you need a GitHub Personal Access Token.

```bash
# 1. Create a GitHub Personal Access Token with 'repo' scope:
#    https://github.com/settings/tokens

# 2. Set the token:
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

# 3. Add the tap:
brew tap leeovery/tools

# 4. Install the tools you need:
brew install stitch          # Release management CLI
brew install bash-toolkit    # Bash messaging library
```

For detailed setup instructions, see [INSTALL.md](INSTALL.md).

## Available Formulas

### Stitch CLI
Release management CLI for coordinated feature releases with GitFlow-inspired workflow.

```bash
brew install stitch
```

**Features:**
- Automatic versioning and release notes
- Git-first deployments with conflict prevention  
- Laravel project integration
- Kubernetes deployment workflows

**Getting Started:**
```bash
cd your-laravel-project
stitch init --type=laravel
stitch feature start my-feature
```

### Bash Toolkit
A modular bash library for terminal messaging, formatting, and user interaction.

```bash
brew install bash-toolkit
```

**Features:**
- Unified `message()` function with semantic types (success, info, warning, error)
- Smart color/styling with Tailwind-inspired naming (text-red, bg-blue, etc.)
- Layout functions with automatic indentation
- User interaction and prompting utilities
- Smart terminal capability detection (tput/ANSI fallback)

**Getting Started:**
```bash
#!/usr/bin/env bash
source $(bash-toolkit common message layout)

title "My Script"
message "Processing files..." "info"
step "Step 1 complete"
message "All done!" "success"
```

## Development

To install from source during development:
```bash
brew install --build-from-source Formula/stitch.rb
```

## Updating Formulas

Formulas are automatically updated via GitHub Actions when new releases are published in the source repositories.