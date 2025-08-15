# leeovery Homebrew Tools

This repository contains Homebrew formulas for leeovery tools.

## Installation

**Authentication Required:** Since this is a private repository, you need a GitHub Personal Access Token.

```bash
# 1. Create a GitHub Personal Access Token with 'repo' scope:
#    https://github.com/settings/tokens

# 2. Set the token:
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

# 3. Install:
brew tap leeovery/tools
brew install stitch
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

## Development

To install from source during development:
```bash
brew install --build-from-source Formula/stitch.rb
```

## Updating Formulas

Formulas are automatically updated via GitHub Actions when new releases are published in the source repositories.