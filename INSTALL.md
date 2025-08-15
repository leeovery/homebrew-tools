# Installing Stitch CLI

## Prerequisites

Since this is a **private repository**, you need GitHub authentication before installing.

## Quick Installation

**GitHub Personal Access Token Required:**

```bash
# 1. Create a GitHub Personal Access Token with 'repo' scope at:
#    https://github.com/settings/tokens

# 2. Set the token:
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

# 3. Install Stitch CLI
brew tap leeovery/tools
brew install stitch
```

**Important:** GitHub CLI (`gh auth login`) does NOT work with Homebrew - you must use environment variables.

## Requirements

- **GitHub authentication** (one of the methods above)
- **Access to leeovery organization** 
- **macOS with Homebrew installed**

## Verification

After installation, verify it works:
```bash
stitch --version
stitch --help
```

## Getting Started

```bash
cd your-laravel-project
stitch init --type=laravel
stitch feature start my-feature
```

## Troubleshooting

**Error: 401 Unauthorized**
- Make sure your GitHub token is set correctly
- Verify you have access to the leeovery organization

**Error: 404 Not Found**  
- Ensure you're authenticated with GitHub
- Check that your token has `repo` scope for private repositories

For more help, contact your team administrator.