# dotfiles

My personal configuration files, kept in one place and linked into each machine with symlinks.

## What's inside

```
dotfiles/
├── install.ps1      # Windows setup script: creates the symlinks
├── install.sh       # Linux setup script: creates the same symlinks
└── claude/
    └── CLAUDE.md    # Global instructions for Claude Code, linked to ~/.claude/CLAUDE.md
```

## What the install scripts do

Both scripts create the same symlinks. If a real file already exists at a target path, the script renames it to a timestamped `.bak` file before linking. Running a script again is safe.

## Setup (Windows)

1. **Allow symlinks.** Turn on Developer Mode (*Settings > System > For developers*), or run PowerShell as Administrator.

2. **Go to the folder that will contain the repo** (cloning creates a `dotfiles` folder inside it):

   ```powershell
   cd <parent-folder>
   ```

3. **Clone the repo:**

   ```powershell
   git clone https://github.com/wyatthoho/dotfiles.git
   ```

4. **Run the install script:**

   ```powershell
   cd dotfiles
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```

5. **Check the link:**

   ```powershell
   Get-Item $HOME\.claude\CLAUDE.md | Select-Object LinkType, Target
   ```

## Setup (Linux)

1. **Go to the folder that will contain the repo** (cloning creates a `dotfiles` folder inside it):

   ```bash
   cd <parent-folder>
   ```

2. **Clone the repo:**

   ```bash
   git clone https://github.com/wyatthoho/dotfiles.git
   ```

3. **Run the install script:**

   ```bash
   bash dotfiles/install.sh
   ```

4. **Check the link:**

   ```bash
   ls -l ~/.claude/CLAUDE.md
   ```

## Manual setup (Windows)

Use this instead of the script when you want the file somewhere other than the default location. It needs the same symlink permission as the script (see step 1 of the Windows setup).

```powershell
New-Item -ItemType SymbolicLink -Path <target-folder>\CLAUDE.md -Target <parent-folder>\dotfiles\claude\CLAUDE.md
```

This fails if a file already exists at the path. Move or delete it first; unlike the script, nothing is backed up for you.

## Manual setup (Linux)

Use this instead of the script when you want the file somewhere other than the default location.

```bash
ln -s <parent-folder>/dotfiles/claude/CLAUDE.md <target-folder>/CLAUDE.md
```

This fails if a file already exists at the path. Move or delete it first; unlike the script, nothing is backed up for you.

## Updating

Edit files in the repo, not at the linked locations. Some editors replace a file when saving, which can silently break the symlink.

```bash
git add -A
git commit -m "docs: update CLAUDE.md"
git push
```

On other machines, pull to get the changes:

```bash
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
