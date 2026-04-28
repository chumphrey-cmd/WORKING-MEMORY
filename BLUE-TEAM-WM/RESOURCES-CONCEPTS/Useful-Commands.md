# Useful Commands

## Linux

```bash
mkdir -p parent/{sub1,sub2} && touch parent/sub1/{file1,file2}.ext parent/sub2/file3.ext
```

* **`mkdir -p`**: The `-p` flag tells the terminal to create the parent directories if they don't exist yet (so it makes `src` and the folders inside it all at once).
* **Brace Expansion `{}`**: This is a bash shortcut. Writing `src/{components,pages}` is read by the terminal as `src/components src/pages`. It saves you from typing the path repeatedly!
* **`&&`**: This chains two commands together. It tells the terminal: "Make the directories first, and *only if that succeeds*, run the `touch` command to create the files."
* **`touch`**: The standard command for creating empty files.

```bash
cd -
```

- Changes to the previously visited directory.

```bash
touch test{1..100}.txt
```

- Creates multiple files with a numbered sequence.

```bash
tail -f error_file.log | grep "ERROR"
```

- Follows a log file in real-time and filters for specific content and used with `grep` to filter log output.

```bash
history 5
```

- Displays the last 5 executed commands.
- Re-execute commands from history using `![Command#]`.

```bash
PATH="/Users/<user_name>/<scripts_directory>:$PATH"
```
- Modifying your file path to make a specific script executable, useful if there is a command that you run very often or for customizing your environment.

- Used to put your personalized scripts directory within the `$PATH` file so that you can access the specific script name anywhere, ONLY for the current session. Does not persist beyond the current session unless you modify the .`bashrc` profile or something to that effect.

```bash
for i in {1..254} ;do (ping -c 1 192.168.1.$i | grep "bytes from" &) ;done
```

- Simple bash ping sweep that I used to use to scan a subnet for connectivity and basic troubleshooting with hardware.

```bash
# Find port that's being used
lsof -i tcp:PORT

# Kill port being used
kill -9 PID
```

* Quick way to locate and kill used ports

```bash
openssl rand -base64 32
```

* Quick way to generate a 64 character SecretKey, but Bitwarden also works too.

## Windows