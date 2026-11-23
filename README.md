# Claude Code beep

Two sound cues for [Claude Code](https://docs.claude.com/en/docs/claude-code), using hooks:

- **Finished** (`Stop` hook): a melodic beep once Claude has completed a task.
- **Needs you** (`Notification` hook): a call for help when waiting for a response.

No sound files. On Windows it uses the built-in PowerShell `[console]::beep(frequency, ms)`; on a Mac it plays built-in system sounds.

## Install

Copy and paste this prompt into Claude Code. Claude adds both hooks to your user settings, keeps any hooks you already have, checks the file and plays each sound once so you can hear them.

```text
Set up friendly beeps for Claude Code on this Windows PC, in my user settings (`~/.claude/settings.json`), so that every project gets them. Use the update-config skill if you have it.

Add two hooks, and MERGE them with any hooks already there. Never replace or remove an existing hook.

1. **Finished (Stop hook):** a melodic beep once Claude has completed a task.
   - type: command, shell: powershell, timeout: 5
   - command: `[console]::beep(659,90); [console]::beep(784,90); [console]::beep(1047,150)`

2. **Needs me (Notification hook):** a call for help when waiting for a response.
   - type: command, shell: powershell, timeout: 5
   - command: `[console]::beep(988,130); [console]::beep(740,130); [console]::beep(988,130); [console]::beep(740,300)`

Afterwards, show me the hooks section of the file. Check it is valid JSON. Then play each command once, so I can hear both sounds.

On a Mac, use `afplay /System/Library/Sounds/Glass.aiff` for Finished and `afplay /System/Library/Sounds/Ping.aiff` for Needs me, with no shell setting.
```

Or [download the prompt](https://github.com/Matthew4509/claude-code-beep/raw/master/install-prompt.txt) ([install-prompt.txt](install-prompt.txt)) and paste it in later.

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

Change the numbers in the prompt before you paste it, or ask Claude to change the tune afterwards.

## Remove

Ask Claude Code to remove the two beep hooks from `~/.claude/settings.json`.

## Notes

- A beep blocks for its own length, so the 5-second hook timeout is generous.
- Some PCs play nothing: no audio device, some remote desktop sessions and virtual machines.

## Licence

MIT, see [LICENSE](LICENSE).
