# dotfiles

My personal configuration files, kept in one place and linked into each machine with symlinks.

## What's inside

```
dotfiles/
├── install.ps1      # Windows setup script: creates the symlinks
├── install.sh       # Linux setup script: creates the same symlinks
└── claude/
    └── CLAUDE.md    # Global instructions for Claude Code
```

| File in this repo  | Linked to                   |
| ------------------ | --------------------------- |
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md`       |

## Setup (Windows)

1. **Allow symlinks.** Turn on Developer Mode (*Settings > System > For developers*), or run PowerShell as Administrator.

2. **Clone the repo:**

   ```powershell
   git clone https://github.com/wyatthoho/dotfiles.git $HOME\dotfiles
   ```

3. **Run the install script:**

   ```powershell
   cd $HOME\dotfiles
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```

4. **Check the link:**

   ```powershell
   Get-Item $HOME\.claude\CLAUDE.md | Select-Object LinkType, Target
   ```

## Setup (Linux)

1. **Clone the repo:**

   ```bash
   git clone https://github.com/wyatthoho/dotfiles.git ~/dotfiles
   ```

2. **Run the install script:**

   ```bash
   bash ~/dotfiles/install.sh
   ```

3. **Check the link:**

   ```bash
   ls -l ~/.claude/CLAUDE.md
   ```

On both systems, if a real file already exists at a target path, the script renames it to a timestamped `.bak` file before linking. Running the script again is safe.

## Updating

Edit files here in the repo, not at the linked locations. They are the same file either way, but this keeps the habit clear.

```powershell
git add -A
git commit -m "Update CLAUDE.md"
git push
```

On other machines, pull to get the changes:

```powershell
git pull
```

## Adding a new file

1. Put the file in the repo, grouped by tool (for example, `claude/settings.json`).
2. Add an entry to `$links` in `install.ps1`:

   ```powershell
   @{ Source = Join-Path $repo 'claude\settings.json'; Target = Join-Path $HOME '.claude\settings.json' }
   ```

3. Add the same entry to `links` in `install.sh`:

   ```bash
   "$repo/claude/settings.json|$HOME/.claude/settings.json"
   ```

4. Run the install script again (`install.ps1` on Windows, `install.sh` on Linux).

## Note

This repo is public. Never commit secrets, API keys, credentials, or anything private.
