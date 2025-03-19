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

## Windows