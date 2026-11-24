# dotfiles

My personal configuration files, kept in one place and linked into each machine with symlinks.

## What's inside

```
dotfiles/
└── claude/
    └── CLAUDE.md    # Global instructions for Claude Code, linked to ~/.claude/CLAUDE.md
```

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

4. **Link the file.** Use any target folder; for Claude Code the default is `$HOME\.claude`:

   ```powershell
   New-Item -ItemType SymbolicLink -Path <target-folder>\CLAUDE.md -Target <parent-folder>\dotfiles\claude\CLAUDE.md
   ```

   This fails if a file already exists at the path. Move or delete it first.

5. **Check the link:**

   ```powershell
   Get-Item <target-folder>\CLAUDE.md | Select-Object LinkType, Target
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

3. **Link the file.** Use any target folder; for Claude Code the default is `~/.claude`:

   ```bash
   ln -s <parent-folder>/dotfiles/claude/CLAUDE.md <target-folder>/CLAUDE.md
   ```

   This fails if a file already exists at the path. Move or delete it first.

4. **Check the link:**

   ```bash
   ls -l <target-folder>/CLAUDE.md
   ```

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
2. Link it into place with the command from step 4 (Windows) or step 3 (Linux) of the setup.

## Note

This repo is public. Never commit secrets, API keys, credentials, or anything private.
