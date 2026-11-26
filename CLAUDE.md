# Claude Context: Homebrew Tools Repository

This file provides comprehensive context to Claude Code when working with the leeovery Homebrew tools repository.

## Repository Overview

**Homebrew Tools** is a private Homebrew tap containing formulas for personal CLI tools. It provides automated formula updates via GitHub Actions when new releases are published in the source repositories.

## Available Tools

### Public (no token required)

**Tick** (`Formula/tick.rb`)
- Priority-based task scheduling CLI (Go, dual-arch macOS binaries)
- `brew install leeovery/tools/tick`

**Portal** (`Formula/portal.rb`)
- Interactive session picker for tmux (Go, dual-arch macOS binaries)
- `brew install leeovery/tools/portal`

**Switchboard** (`Formula/switchboard.rb`)
- Spreads Claude Code sessions across several Claude subscriptions (Go, dual-arch macOS binaries)
- `brew install leeovery/tools/switchboard`

**Terrace** (`Formula/terrace.rb`)
- Shared, gated infrastructure runs for you and your AI agent (Go, dual-arch macOS binaries)
- Committed with `version "0.0.0"` and two sha256s of 64 zeros as placeholders: the first release's dispatch writes the real values
- `brew install leeovery/tools/terrace`

### Private (requires `HOMEBREW_GITHUB_API_TOKEN`)

**Stitch** (`Formula/stitch.rb`)
- The Go Stitch, the shipping tool (Go, dual-arch macOS binaries, `GitHubPrivateReleaseDownloadStrategy`)
- `version_scheme 1`, from 0.1.0, so its own semver reads as newer than the bash Stitch's 1.6.6, which this formula installed until then; the workflow's edits leave it as it is
- `brew install leeovery/tools/stitch`

**Press** (`Formula/press.rb`)
- press, which builds, signs, notarises and ships a project's release on a Mac (Go, dual-arch macOS binaries, `GitHubPrivateReleaseDownloadStrategy` while its repo is private)
- Committed with `version "0.0.0"` and two sha256s of 64 zeros as placeholders: the first release's dispatch writes the real values
- Its first release, 0.1.0, comes from the Python press through `update-formula.yml`: `tool=press` with `version`, `sha256_arm64` and `sha256_amd64`, checked and written as stitch's are. From 0.2.0 press sends the whole formula, rendered from `packaging/homebrew/press.rb` in its repo, to `write-formula.yml`, and the `press` branch in `update-formula.yml` goes
- `brew install leeovery/tools/press`

**Stitch Bash** (`Formula/stitch-bash.rb`)
- The bash Stitch, for apps still on the old platform, run as `stitch-bash` (`GitHubPrivateReleaseDownloadStrategy`)
- Its script finds its library and templates beside itself, so all of it lives in `libexec`, behind a `stitch-bash` wrapper
- `brew install leeovery/tools/stitch-bash`

**Bash Toolkit** (`Formula/bash-toolkit.rb`)
- Modular bash library for terminal messaging and UI (same private download strategy)
- `brew install leeovery/tools/bash-toolkit`

### Casks

**SitRep** (`Casks/sitrep.rb`)
- The SitRep menu bar app, which carries and installs the sitrep Claude Code plugin (Swift, arm64 only, macOS 14+; bundle id `com.leeovery.sitrep`)
- Public since 18 November 2026: downloads the release's zip from its public URL, `https://github.com/leeovery/sitrep/releases/download/v<version>/SitRep-<version>.zip`, named by `[package] name` in sitrep's `.press.toml`, with no token and no download strategy of its own
- `auto_updates` unset, so `brew upgrade` updates the app; `livecheck` reads GitHub's latest release
- `binary` links the CLI the bundle carries for its plugin into Homebrew's bin, so a login shell finds `sitrep`
- `uninstall quit:` the app and its notices helper, `com.leeovery.sitrep.notices`; Homebrew opens again whichever it quit once an upgrade is done, and SitRep's start refreshes the plugin it carries. No `postflight`: Homebrew 7 deprecates it, and `postflight_steps` run in a sandbox where `open` finds no executable in the app (-10827, Homebrew 7.0.11)
- `zap` never takes `~/.local/state/sitrep`, which is the board itself, nor `~/Library/Logs/press`, where press logs every project's releases on a Mac that releases; `~/Library/Logs/SitRep`, where sitrep's release scripts logged before press, nothing writes now
- Updated by the workflow: `tool=sitrep` with `version` and `sha256`, dispatched by `press upload` after each upload of the latest release, which then waits on the workflow's run. The workflow checks them against `X.Y.Z` and 64 hex digits before it writes them, each to its own line of the cask, and commits "Update sitrep cask to v…"
- `brew install --cask leeovery/tools/sitrep`

**Spaceman** (`Casks/spaceman.rb`)
- The Spaceman menu bar app, which shows and names Spaces (Swift, universal arm64 and x86_64, macOS 26 Tahoe+; bundle id `com.leeovery.Spaceman`)
- Public: downloads the release's zip from its public URL, `https://github.com/leeovery/spaceman/releases/download/v<version>/Spaceman-<version>.zip`, named by `[package] name` in spaceman's `.press.toml`, with no token and no download strategy of its own
- `auto_updates` unset, so `brew upgrade` updates the app; `livecheck` reads GitHub's latest release
- `uninstall quit:` the app. No `binary` and no `postflight`
- Committed with `version "0.0.0"` and a sha256 of 64 zeros as placeholders: the first release's dispatch writes the real values
- Updated by the workflow: `tool=spaceman` with `version` and `sha256`, dispatched by `press upload`. The workflow checks them against `X.Y.Z` and 64 hex digits before it writes them, each to its own line of the cask, and commits "Update spaceman cask to v…"
- `brew install --cask leeovery/tools/spaceman`

## Architecture

### Formula Structure
Two patterns exist:

**Public tools (tick, portal, switchboard, terrace, mint):** Standard Homebrew formulas with dual-arch macOS support: `depends_on :macos`, then `on_arm` / `on_intel` blocks at the top level, each with its own URL and sha256. Not inside an `on_macos` block: Homebrew 7 checks a trusted tap's formulae for every OS and arch when it's tapped, and a formula with no URL on Linux fails it ("invalid syntax in tap!"). Updated via `sha256_arm64` / `sha256_amd64` in the dispatch payload.

**Private tools (stitch, press, stitch-bash):** Use `GitHubPrivateReleaseDownloadStrategy`, defined in each formula:
- Requires `HOMEBREW_GITHUB_API_TOKEN`; without it the download stops, saying so
- Finds the asset by its file name in the release the URL names, through GitHub's API, so the formula keeps no asset IDs
- Hands the token to curl on stdin (`--header @-`), so it never shows in a command line; `secrets:` redacts it from any output, and `--disable` keeps a `~/.curlrc` out
- Raises `CurlDownloadStrategyError` on a failure, never `odie`, which Homebrew's download threads swallow as `Error: exit`
- Each formula holds the same strategy, so a change to it is made in each. press's copy is made in press's own repo, in `packaging/homebrew/press.rb`: from press 0.2.0 each release writes `Formula/press.rb` whole from that template, so a change made only here would be undone
- stitch and press have `on_arm` / `on_intel` blocks as the public tools do, updated by `sha256_arm64` / `sha256_amd64` (press's payload); stitch-bash one archive, updated by `sha256`; the workflow refuses a payload without them

**bash-toolkit** keeps the older `GitHubPrivateRepositoryDownloadStrategy`, which maps version numbers to GitHub release asset IDs and falls back to a plain download without a token.

### Automated Updates
The repository uses GitHub Actions (`.github/workflows/update-formula.yml`) to automatically update formulas:

1. **Trigger**: Repository dispatch events from source repositories
2. **Payload**: Includes tool name, version, SHA256, asset ID, and download URL
3. **Process**: Updates appropriate formula file and commits changes
4. **Support**: Handles `stitch`, `press`, `stitch-bash`, `bash-toolkit`, `tick`, `portal`, `mint`, `switchboard`, `terrace`, `sitrep` and `spaceman` via tool parameter
5. **One at a time**: a `concurrency` group queues a dispatch behind one running, so two can't race each other's `git push`. GitHub keeps only one pending run a group, so a third dispatch while one waits cancels the waiting one; a run times out after 5 minutes
6. **Named by its payload**: `run-name` makes each run "Update <tool> to v<version>", so a sender waiting on its run (`press upload`, which kit, mint, switchboard, terrace, sitrep and spaceman release through) tells it from another tool's that started beside it; keep the name as it is, or change the sender with it

### Written Whole (`write-formula.yml`)
A second workflow, `.github/workflows/write-formula.yml`, writes a formula or cask that press sends whole, rendered from the project's own template, so it knows no tool. It runs beside `update-formula.yml` until every project sends through it:

1. **Trigger**: a `repository_dispatch` of `write-formula`
2. **Payload**: `tool`, `kind` (`formula` or `cask`), `version`, `content` (the file, base64), `content_sha256`, `dispatch` (8 random hex digits) and `dry_run`
3. **Process**: `scripts/write-formula`, which takes the payload through the environment and refuses, saying what was wrong:
   - a `tool` that isn't `^[a-z0-9][a-z0-9-]*$`, a `kind` that's neither `formula` nor `cask`, or a `version` that isn't `X.Y.Z`;
   - content that isn't base64, or whose sha256 isn't `content_sha256`;
   - content without a line `  version "<version>"`, or without the formula's `class <Name> < Formula` (`Name` derived from the tool as Homebrew derives it) or the cask's `cask "<tool>" do`;
   - content `ruby -c` rejects.
4. **The file** is `Formula/<tool>.rb` or `Casks/<tool>.rb`, derived from the payload and never sent in it, so a first release needs no file committed here first
5. **Writing**: it fetches main and resets to its tip, then refuses when `<tool>.rb` is already in the other folder (a cask for a formula, or the reverse) or the tap's file holds a newer version than the one sent (`sort -V`). With `dry_run` true it prints the `diff -u` against that tip and writes nothing; otherwise it commits "Update <tool> formula to v…" (or cask) as the GitHub Action, exits 0 when the file already reads as sent, and pushes. A push refused because main moved on (no fast-forward) starts again from main's new tip, checks included, up to five attempts with a growing, jittered wait, then fails; any other push failure (auth, network) fails at once in git's own words; the content is the whole file, so there is nothing to merge
6. **Side by side**: no `concurrency` group, because GitHub keeps one pending run a group and a third dispatch would cancel the one waiting. Runs go side by side, made safe by step 5: nothing is ever cancelled, and runs that finish out of order never take a file back a version. `update-formula.yml`'s push, which doesn't retry, can still lose a race to it and fail its run. A run times out after 5 minutes
7. **Named by its payload**: `run-name` is "Write <kind> <tool> v<version> (<dispatch>)", so press tells its run from a resend or a neighbour's; keep it as it is, or change press with it

`scripts/write-formula-test` runs the script against a temporary clone with a bare remote: writes, an unchanged write, dry runs, a stale depth-1 clone, main moving on mid-push (a git shim on the script's PATH pushes first), retries running out, a push failing for another reason, and each refusal. `WRITE_FORMULA_BACKOFF` (seconds, default 2) scales the wait, plus up to as much again at random, between push attempts; the tests set it to 0. It needs git, ruby, base64 and sha256sum; `.github/workflows/test.yml` runs it on pull requests that touch `scripts/` or `.github/`.

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
4. Add tool documentation to README.md

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

# Casks: Homebrew loads a cask only from a trusted tap, never from a path,
# so check a branch's cask from a scratch tap (brew tap-new --no-git, its
# Casks/ given the file, brew trust), then brew untrust and brew untap it
brew style --cask <tap>/[cask-name]
brew audit --cask --strict <tap>/[cask-name]
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

- `Formula/tick.rb` - Tick formula (public, dual-arch macOS)
- `Formula/portal.rb` - Portal formula (public, dual-arch macOS)
- `Formula/stitch.rb` - Stitch formula, the Go Stitch (private, dual-arch macOS, custom download strategy)
- `Formula/press.rb` - Press formula (private, dual-arch macOS, custom download strategy)
- `Formula/stitch-bash.rb` - Stitch Bash formula, the bash Stitch as `stitch-bash` (private, custom download strategy)
- `Formula/bash-toolkit.rb` - Bash Toolkit formula (private, custom download strategy)
- `Casks/sitrep.rb` - SitRep cask (public, its release's zip by version in the url)
- `Casks/spaceman.rb` - Spaceman cask (public, its release's zip by version in the url)
- `.github/workflows/update-formula.yml` - Automated formula update workflow
- `.github/workflows/write-formula.yml` - Writes a formula or cask press sends whole, through `scripts/write-formula`
- `scripts/write-formula-test` - The write-formula script's tests, run by `.github/workflows/test.yml`
- `README.md` - Main documentation with installation instructions

## Important Notes

- Private tools (stitch, press, stitch-bash, bash-toolkit) require authentication; public tools (tick, portal) do not
- bash-toolkit's asset IDs are updated by the workflow on each release; stitch, press and stitch-bash keep none
- The custom download strategy is essential for private repository access
- Public formulas use dual-arch sha256 checksums instead of asset IDs
- Workflow updates all formulas based on the tool parameter in the payload
- Manual formula edits should preserve the asset ID mapping structure (private) or dual-arch block (public)