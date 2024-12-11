# Linux Host Enumeration 🐧

## Determining if History Configuration has been Modified or Deleted

### Check for History File:
   
```bash
more ~/.bash_history
```
**Indicators of Modified History File**:
   - `.bash_history` does not exist or is empty = history logging is disabled or has been cleared.

### Review Shell Configuration File:

- Check the user's **`.bashrc`** or **`.bash_profile`** files for settings that control history behavior:

```bash
grep 'HISTSIZE\|HISTFILESIZE\|HISTIGNORE\|HISTCONTROL' ~/.bashrc ~/.bash_profile
```

- `HISTSIZE` and `HISTFILESIZE`: These control the number of commands stored in memory and on disk, respectively.
  
   **Indicators of Disabled History**:
  - `HISTSIZE` or `HISTFILESIZE` = 0, disables history logging
  - `unset HISTFILE` = prevents the history from being saved to a file.
  
- `HISTIGNORE`: Specifies patterns of commands to ignore.
  
- `HISTCONTROL`: Can include options like `ignorespace` (ignore commands that start with a space) or `ignoredups` (ignore duplicate commands).
