# Claude Context: Homebrew Tools Repository

This file provides comprehensive context to Claude Code when working with the leeovery Homebrew tools repository.

## Repository Overview

**Homebrew Tools** is a private Homebrew tap containing formulas for personal CLI tools. It provides automated formula updates via GitHub Actions when new releases are published in the source repositories.

## Available Tools

### Stitch CLI (`Formula/stitch.rb`)
- **Purpose**: Release management CLI for coordinated feature releases
- **Repository**: https://github.com/leeovery/stitch
- **Installation**: `brew install leeovery/tools/stitch`
- **Key Features**: GitFlow-inspired workflow, automatic versioning, Laravel integration

### Bash Toolkit (`Formula/bash-toolkit.rb`) 
- **Purpose**: Modular bash library for terminal messaging, formatting, and user interaction
- **Repository**: https://github.com/leeovery/bash-toolkit
- **Installation**: `brew install leeovery/tools/bash-toolkit`
- **Key Features**: Unified message() API, smart coloring, layout functions, user prompts

## Architecture

### Formula Structure
Both formulas use a custom `GitHubPrivateRepositoryDownloadStrategy` to handle private repository access:
- Requires `HOMEBREW_GITHUB_API_TOKEN` environment variable
- Maps version numbers to GitHub release asset IDs
- Falls back to standard download if token unavailable

### Automated Updates
The repository uses GitHub Actions (`.github/workflows/update-formula.yml`) to automatically update formulas:

1. **Trigger**: Repository dispatch events from source repositories
2. **Payload**: Includes tool name, version, SHA256, asset ID, and download URL
3. **Process**: Updates appropriate formula file and commits changes
4. **Support**: Handles both `stitch` and `bash-toolkit` tools via tool parameter

## Workflow Integration

### Source Repository Workflow
Each tool repository has a workflow (`update-homebrew-formula.yml`) that:
1. Creates GitHub release with binary tarball on version tags
2. Calculates SHA256 hash for Homebrew verification
3. Triggers this repository's update workflow with tool-specific payload

### Formula Update Process
The update workflow (`update-formula.yml`):
1. Receives tool name, version, SHA256, and asset ID from source repository
2. Determines which formula file to update based on tool name
3. Updates version, URL, SHA256, and asset ID mapping in the formula
4. Commits and pushes changes automatically

## Development Patterns

### Adding New Tools
To add a new tool to the tap:
1. Create new formula file in `Formula/[tool-name].rb`
2. Use the `GitHubPrivateRepositoryDownloadStrategy` pattern
3. Update the workflow to handle the new tool name
4. Add tool documentation to README.md and INSTALL.md

### Formula Maintenance
- Asset ID mappings are automatically maintained by the workflow
- Manual updates should preserve the custom download strategy
- Version updates should be done via the automated workflow, not manually

### Testing Installation
```bash
# Test formula syntax
brew audit --strict Formula/[tool-name].rb

# Test local installation
brew install --build-from-source Formula/[tool-name].rb

# Test from tap
brew install leeovery/tools/[tool-name]
```

## Authentication Requirements

### For Users
- GitHub Personal Access Token with 'repo' scope
- Access to leeovery repositories
- Token set as `HOMEBREW_GITHUB_API_TOKEN` environment variable

### For Automation
- `CICD_PAT_2` secret for triggering repository dispatch events
- Token must have access to both source repositories and homebrew-tools

## Key Files

- `Formula/stitch.rb` - Stitch CLI formula with custom download strategy
- `Formula/bash-toolkit.rb` - Bash Toolkit formula with custom download strategy  
- `.github/workflows/update-formula.yml` - Automated formula update workflow
- `README.md` - Main documentation with installation instructions
- `INSTALL.md` - Detailed installation guide with troubleshooting

## Important Notes

- Both tools are in private repositories requiring authentication
- Asset IDs must be updated in formulas when new releases are created
- The custom download strategy is essential for private repository access
- Workflow updates both formulas based on the tool parameter in the payload
- Manual formula edits should preserve the asset ID mapping structure