# Claude Code beep

Two tiny sound cues for [Claude Code](https://docs.claude.com/en/docs/claude-code) on Windows, using hooks:

- **Done** (`Stop` hook): a short rising three-note chime when Claude finishes a reply.
- **Needs you** (`Notification` hook): a two-note alternating alert when Claude is waiting for permission or input.

No downloads, no sound files. It uses the built-in PowerShell `[console]::beep(frequency, ms)`.

## Install

### Option 1: script (merges into your existing settings)

```powershell
git clone https://github.com/<your-user>/claude-code-beep.git
cd claude-code-beep
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

The script backs up `~/.claude/settings.json` first, keeps your existing settings and hooks, and skips any event that already has a beep.

### Option 2: by hand

Copy the `hooks` block from [`hooks.json`](hooks.json) into `%USERPROFILE%\.claude\settings.json`. If you already have `Stop` or `Notification` hooks, add the entries to those arrays instead of replacing them.

Restart Claude Code afterwards.

## Change the tune

Each `[console]::beep(F, D)` plays frequency `F` in Hz for `D` milliseconds. Some notes:

| Note | Hz   |
|------|------|
| E5   | 659  |
| F#5  | 740  |
| G5   | 784  |
| B5   | 988  |
| C6   | 1047 |

## Remove

Delete the two beep entries from `~/.claude/settings.json`, or restore the `.bak-` file the installer made.

## Notes

- Windows only (`[console]::beep` needs a Windows console audio path). On macOS you could swap in `afplay /System/Library/Sounds/Glass.aiff`.
- A beep blocks for its own length, so the 5-second hook timeout is generous.

## Licence

MIT, see [LICENSE](LICENSE).
