# Useful Commands

## Linux

```bash
mkdir -p {dev,test,prod}/{backend,frontend}
```

- Creates multiple nested directories.

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

- Follows a log file in real-time and filters for specific content.
- **Bonus:** Combine `tail -f` with `grep` to filter log output.

```bash
history 5
```

- Displays the last 5 executed commands.
- **Bonus:** Re-execute commands from history using `![Command#]`.

```bash
PATH="/Users/<user_name>/<scripts_directory>:$PATH"
```
- Modifying your file path to make a specific script executable, useful if there is a command that you run very often or for customizing your environment.

- Used to put your personalized scripts directory within the `$PATH` file so that you can access the specific script name anywhere, ONLY for the current session. Does not persist beyond the current session unless you modify the .`bashrc` profile or something to that effect.

## Git Basics

1. https://dev.to/mollynem/git-github--workflow-fundamentals-5496

### Git Work Flow

<img src="./images/git_workflow.webp">

* 

## Windows