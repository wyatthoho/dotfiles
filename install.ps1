# install.ps1 - link dotfiles into place on Windows
# Usage (from the repo folder):
#   powershell -ExecutionPolicy Bypass -File .\install.ps1
#
# Creating symlinks on Windows needs either:
#   - Developer Mode turned on (Settings > System > For developers), or
#   - running PowerShell as Administrator.

$ErrorActionPreference = 'Stop'
$repo = $PSScriptRoot

# Each entry: source in the repo -> target on this machine.
# Add more lines here later (settings.json, commands, agents, ...).
$links = @(
    @{ Source = Join-Path $repo 'claude\CLAUDE.md'; Target = Join-Path $HOME '.claude\CLAUDE.md' }
)

foreach ($link in $links) {
    $src = $link.Source
    $dst = $link.Target

    if (-not (Test-Path $src)) {
        Write-Warning "Source not found, skipping: $src"
        continue
    }

    # Make sure the parent folder exists
    $parent = Split-Path $dst -Parent
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent | Out-Null
    }

    # Handle anything already at the target
    if (Test-Path $dst) {
        $item = Get-Item $dst -Force
        if ($item.LinkType -eq 'SymbolicLink' -and $item.Target -eq $src) {
            Write-Host "Already linked: $dst" -ForegroundColor DarkGray
            continue
        }
        if ($item.LinkType -eq 'SymbolicLink') {
            Remove-Item $dst -Force
        } else {
            $backup = "$dst.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Move-Item $dst $backup
            Write-Host "Backed up existing file to $backup" -ForegroundColor Yellow
        }
    }

    try {
        New-Item -ItemType SymbolicLink -Path $dst -Target $src | Out-Null
        Write-Host "Linked $dst -> $src" -ForegroundColor Green
    } catch {
        Write-Host "Could not create symlink: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Turn on Developer Mode (Settings > System > For developers) or run PowerShell as Administrator, then try again."
        exit 1
    }
}
