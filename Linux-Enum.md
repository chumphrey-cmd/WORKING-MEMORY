# Useful Host Enumeration Commands (Linux)

## Determining if History Configuration has been Modified or Deleted

1. **Check for History File**:

- Locate the hidden **`.bash_history`** file in the user's home directory. You can check if this file exists and whether it is empty:

- If the file does not exist or is empty, it could indicate that history logging is disabled or has been cleared.

2. **Review Shell Configuration Files**:

- Check the user's **`.bashrc`** or **`.bash_profile`** files for settings that control history behavior:

```bash

grep 'HISTSIZE\|HISTFILESIZE\|HISTIGNORE\|HISTCONTROL' ~/.bashrc ~/.bash_profile
  
```

- `HISTSIZE` and `HISTFILESIZE`: These control the number of commands stored in memory and on disk, respectively.
  
   NOTE: **Indicators of Disabled History**:
  - `HISTSIZE` or `HISTFILESIZE` = 0, disables history logging
  - `unset HISTFILE` = prevents the history from being saved to a file.
  
- `HISTIGNORE`: Specifies patterns of commands to ignore.
  
- `HISTCONTROL`: Can include options like `ignorespace` (ignore commands that start with a space) or `ignoredups` (ignore duplicate commands).
