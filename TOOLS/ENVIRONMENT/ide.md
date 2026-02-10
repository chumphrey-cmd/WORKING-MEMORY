# Setting Up IDE

## Add Cmder Terminal Interface to VSCode

* Download Cmder terminal **[here](https://cmder.app/).**  
* Move extract and move cmder files to the directory of your choice  
  * E.g., **`C:\Program Files (x86)\Path\to\Cmder`**  
* Open VSCode and use **`Ctrl + Shift + P`** to open settings  
* Enter: “settings user json” to access User VSCode settings  
* Enter the following into the JSON configuration file underneath the current configs within the curly braces “{}”

```json
{

    "terminal.integrated.profiles.windows": {

        "Cmder": {

            "name": "Cmder",

            "path": "C:\\Windows\\system32\\cmd.exe",

            "args": ["/k", "C:\\Program Files (x86)\\cmder\\vendor\\init.bat"],

            "icon": "terminal-cmd",

            "color": "terminal.ansiGreen"

        }

    },

    "terminal.integrated.defaultProfile.windows": "Cmder"

}
```

* Restart VSCode  
* Cmder is now the default terminal application in VSCode.

## Install WSL 

* https://learn.microsoft.com/en-us/windows/wsl/install
* Verify that Git Bash is installed and present within VSCode IDE.

## Add SSH Keys to GitHub (Windows)

1. **Launch the Git Bash from VSCode**

2. **Generate a New SSH Key**

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
Replace email with your GitHub email and press Enter. Accept the default file location and passphrase options by pressing Enter again when prompted.  

3. **Start the SSH Agent via Bash Terminal**

```bash
eval "$(ssh-agent -s)"
```

4. **Add Your Private Key** 

```bash 
ssh-add ~/.ssh/id_ed25519
```
Press Enter (adjust the path if you named your key differently).  

5. **Copy Your Public Key** 

```bash
cat ~/.ssh/YOUR_PUB_KEY.pub
```
* Select and copy the entire output.

> [!NOTE]
> The process of adding keys has been updated. You now need to add separate Authenticaion **AND** Signing Keys to push verified commits to GitHub.

6. **Add Authentication SSH Key to GitHub**  
    * Go to your GitHub account settings: Settings > SSH and GPG keys.  
    * Click "New SSH key" 
    * Press `Key type` and select `Authenticaion Key`
    * Give your key a title and paste the copied public key.  
    * Paste the contents copied from `cat ~/.ssh/YOUR_PUB_KEY.pub` into the `Key` field.
    * Click "Add SSH key" 

7. **Add Signing Key to GitHub**
    * Same process as above, but when selecting `Key Types` select `Signing Key`. 

8.  **Test the Connection** 

```bash 
ssh -T git@github.com
```
You should see a success message.

## Add SSH Keys to GitHub (macOS)

> [!NOTE]
> This process is closely related to the Windows with a few differences... I've just extracted the essential commands we need for the process. Here's the [link](https://medium.com/codex/git-authentication-on-macos-setting-up-ssh-to-connect-to-your-github-account-d7f5df029320) for the full process...

### Generate a new SSH key on your computer (or use an existing SSH key)

1. **Generate a New SSH Key**

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
* Replace email with your GitHub email and press Enter. Accept the default file location and passphrase options by pressing Enter again when prompted.

### Add the SSH key to the ssh-agent

1. **Start the SSH Agent via Bash Terminal**

```bash
eval "$(ssh-agent -s)"
```

2. Add your SSH private key to the **`ssh-agent`**

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

3. **Set up the config file for some convenient options**

* If you don’t already have the `config` file inside your `/.ssh` folder, create one:

```bash
touch ~/.ssh/config
```

### Add the Public SSH key to your GitHub account and Test

1. Copy the content of your SSH public key and paste to your GitHub SSH and GPG Keys [page](https://github.com/settings/keys).

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

2. **Add Authentication SSH Key to GitHub**  
* Go to your GitHub account settings: Settings > SSH and GPG keys.  
* Click "New SSH key" 
* Press `Key type` and select `Authenticaion Key`
* Give your key a title and paste the copied public key.  
* Paste the contents copied from `pbcopy` into the `Key` field.
* Click "Add SSH key" 

3. **Add Signing Key to GitHub**
* Same process as above, but when selecting `Key Types` select `Signing Key`.

4. Test GitHub connection

```bash
ssh -T git@github.com
```

> [!NOTE]
> Additional troubleshooting may be needed if you receive the following error:
> * **`error: gpg failed to sign the data fatal: failed to write commit object`**
> *  To resolve, follow these [steps](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-ssh-key).

```bash
# Format SSH for GPG
git config --global gpg.format ssh
```

```bash
# Assign public SSH key as a global variable
git config --global user.signingkey /PATH/TO/.SSH/KEY.PUB
``` 

# Troubleshooting IDE

## Re-signing Unverified Commits via Interactive Rebase

> This process amends the existing commit history to add an SSH signature. This should only be done on branches **you** own exclusively.

Prerequisites
* Your public SSH key is added as a "Signing Key" in GitHub Settings.

Your local Git config is set for SSH signing:

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519 # (Use your key path)
git config --global commit.gpgsign true
```

**Step 1: Start the Interactive Rebase**

* Navigate to your repository and initiate an interactive rebase. Replace `N` with the number of unverified commits you need to fix.

```bash
git rebase -i HEAD~N
```

**Step 2: Mark Commits for Editing**

A text editor will open. Change the command `pick` to `edit` for every commit you wish to re-sign. Commits are listed from **oldest (top) to newest (bottom)**.

```bash
edit 8a2b3c4 chore: update file A # Oldest
edit 5d6e7f8 feat: add feature B
pick f1a2b3c # (Already verified, leave as pick)
# ...
```

Save and close the editor (`wq!`)

**Step 3: Sign Each Commit Manually**

* Git will pause at the first commit marked edit. You are now in an (interactive) rebase state. For each paused commit, run these two commands:

```bash
git commit --amend --no-edit -S
```

```bash
git rebase --continue
```
* `--no-edit -S`: Amends the commit with a signature without changing the message.
* `git rebase --continue`: Moves the process to the next edit commit or finishes the rebase.

Repeat these two commands until the rebase is complete and your terminal prompt returns to normal.

**Step 4: Force-Push to GitHub**

Rewrite the commit history to overwrite the remote branch on GitHub:

```bash
git push --force-with-lease origin HEAD
```

**Step 5: Verify Contributions**

Check your GitHub repository/profile page. Commits should now show as "**Verified**" and appear on your contribution graph.



