# Installing Personal Tools

## Prerequisites

Since these are **private repositories**, you need GitHub authentication before installing.

## Quick Installation

**GitHub Personal Access Token Required:**

```bash
# 1. Create a GitHub Personal Access Token with 'repo' scope at:
#    https://github.com/settings/tokens

# 2. Set the token:
export HOMEBREW_GITHUB_API_TOKEN=your_token_here

# 3. Add the tap:
brew tap leeovery/tools

# 4. Install the tool you need:
brew install stitch          # Release management CLI
brew install bash-toolkit    # Bash messaging library
```

**Important:** GitHub CLI (`gh auth login`) does NOT work with Homebrew - you must use environment variables.

## Requirements

- **GitHub authentication** (one of the methods above)
- **Access to leeovery organization** 
- **macOS with Homebrew installed**

## Verification

### Stitch CLI
```bash
stitch --version
stitch --help
```

### Bash Toolkit
```bash
bash-toolkit --help
source $(bash-toolkit common)
message "Hello, World!" "success"
```

## Getting Started

### Stitch CLI (Release Management)
```bash
cd your-laravel-project
stitch init --type=laravel
stitch feature start my-feature
```

### Bash Toolkit (Library Usage)
```bash
#!/usr/bin/env bash
source $(bash-toolkit common message layout)

title "My Script"
message "Processing..." "info"
step "Step 1 complete"
message "Done!" "success"
```

## Troubleshooting

**Error: 401 Unauthorized**
- Make sure your GitHub token is set correctly
- Verify you have access to the leeovery organization

**Error: 404 Not Found**  
- Ensure you're authenticated with GitHub
- Check that your token has `repo` scope for private repositories

For more help, contact your team administrator.