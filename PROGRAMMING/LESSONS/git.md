# Git Basics

## Git Basic Work Flow
1. https://dev.to/mollynem/git-github--workflow-fundamentals-5496

<img src="images/git_workflow.png">

## Git Branching Workflow: Step-by-Step Guide

### Step 1: Establish Your Foundation (The Main Branch)
Initialize Git in your project folder and save your current progress before making new changes.
* `git init` - Tells Git to start watching this folder.
* `git add .` - Gets all your current files ready to be saved (staged).
* `git commit -m "Initial commit"` - Takes a snapshot of your working code.

### Step 2: Create and Switch to a Feature Branch
Create a safe space to work on new features without risking your main, working code.
* `git switch -c your-branch-name` - Creates a new branch and switches you to it instantly.

### Step 3: Work on Your Feature
Make changes to your HTML or CSS files. Once you are happy with the progress, save it to your branch.
* `git add .` - Stages your new changes.
* `git commit -m "Describe the feature you added"` - Takes a snapshot of your new feature on this branch.

### Step 4: Review Your Changes (Pre-Merge Check)
Before merging, verify exactly what code is about to be added or changed in your main project.
* `git switch main` - Return to your main trunk first.
* `git diff main..your-branch-name` - See a line-by-line, color-coded comparison of the exact code changes (Green = added, Red = deleted). Press `q` to exit the view.
* `git log main..your-branch-name` - (Optional) See a quick list of the commit messages that are about to be merged.

### Step 5: Merge the Feature Back to Main
Once you have reviewed the changes and everything looks good, bring it into your main project trunk.
* `git merge your-branch-name` - Pulls the completed work from your feature branch into your main code.

### Step 6: Clean Up (Optional but Recommended)
Delete the feature branch to keep your workspace tidy once the merge is successful.
* `git branch -d your-branch-name` - Deletes the finished branch.

### Advanced Scenario A: Returning to an Existing Branch
If you stepped away from a branch or need to go back and make more edits before merging:
* `git switch your-branch-name` - Moves you back into your existing feature branch.
* Make your additional HTML/CSS edits, then save them just like in Step 3:
    * `git add .`
    * `git commit -m "Made additional edits to the feature"`

### Advanced Scenario B: Rebasing and Handling Conflicts
If `main` has been updated since you created your branch, you should "rebase" to keep your project history clean.
* `git switch your-branch-name` - Ensure you are currently inside your feature branch.
* `git fetch` - (Optional but good practice) Grabs the latest updates if working with a remote repo like GitHub.
* `git rebase main` - Re-applies your branch's changes directly on top of the latest `main` code.

**Dealing with Merge Conflicts During a Rebase:**
If Git spots conflicting code, it will pause the rebase.
1. Open the conflicting files in your code editor. Choose which code to keep and delete the rest.
2. `git add .` - Stage the resolved files to tell Git you fixed them.
3. `git rebase --continue` - Tells Git to move on to the next commit. *(Note: Do NOT run `git commit` here!)*
   *Repeat steps 1-3 if Git pauses again, until it says the rebase is successful.*

## Git Multi-Account Authentication Setup

* Reference: https://www.freecodecamp.org/news/git-config-how-to-configure-git-settings/

### Step 1: Organize Your Project Folders
Create separate directories to act as the "trigger" for each Git profile.
* Create a folder for personal work: `mkdir ~/personal-projects`
* Create a folder for professional work: `mkdir ~/work-projects`

### Step 2: Create Profile-Specific Config Files
Create individual configuration files in your home directory (`~`) for each identity.

#### .gitconfig-personal
```ini
[user]
    name = Your Personal Name
    email = personal@email.com
[core]
    # Link specific SSH key for this profile
    sshCommand = "ssh -i ~/.ssh/id_ed25519_personal"
```

#### .gitconfig-work

```ini
[user]
    name = Your Work Name
    email = work@company.com
[core]
    # Link specific SSH key for this profile
    sshCommand = "ssh -i ~/.ssh/id_ed25519_work"
```

### Step 3: Configure the Global .gitconfig

Edit your main `~/.gitconfig` file. Using `gitdir/i:` ensures case-insensitivity, making the setup more robust across different operating systems.

**Note:** Ensure paths end with a trailing slash `/`.

```ini
# Global settings
[user]
    name = Default Name
    email = default@email.com

# Apply personal config if inside the personal-projects directory
[includeIf "gitdir/i:~/personal-projects/"]
    path = ~/.gitconfig-personal

# Apply work config if inside the work-projects directory
[includeIf "gitdir/i:~/work-projects/"]
    path = ~/.gitconfig-work
```

### Step 4: Generate SSH Keys (Authentication)

Generate unique keys for each account.

1. **Personal Key:**
   `ssh-keygen -t ed25519 -C "personal@email.com" -f ~/.ssh/id_ed25519_personal`
2. **Work Key:**
   `ssh-keygen -t ed25519 -C "work@company.com" -f ~/.ssh/id_ed25519_work`

*Add the `.pub` versions of these keys to your respective Git hosting accounts (Settings > SSH and GPG keys).*

### Step 5: Start the SSH Agent

To ensure your computer "remembers" these keys during a session, add them to the SSH agent:

```bash
# Start the agent in the background
eval "$(ssh-agent -s)"

# Add your specific keys
ssh-add ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_work
```

### Step 6: Verification

Navigate into your folders and check if the configuration switched correctly.

```bash
cd ~/work-projects
git config user.email
# Expected Output: work@company.com

cd ~/personal-projects
git config user.email
# Expected Output: personal@email.com
```


## Handling Pull Requests

> [!NOTE]
> Using the GitHub UI for the final "Squash and Merge" is the preferred industry standard over using `git merge` in the CLI. It keeps the repository history much cleaner!

### Phase 1: The Visual "Smell Test" (On GitHub)
Before touching your terminal, review the code in the browser to ensure it is safe.

1. Go to the **Files changed** tab on the Pull Request.
2. **Check scripts (`.sh`, `.ps1`, `.bat`):** Look for destructive commands (like `rm -rf /`), hidden `sudo` requests, or suspicious network calls (`curl http://sketchy-site.com`).
3. **Check dependencies (`requirements.txt`):** Ensure there are no maliciously misspelled packages (e.g., `reqeusts` instead of `requests`).
4. **Read the logic:** Does the code actually do what the PR description claims?

### Phase 2: The Safe Local Checkout (In Terminal)
Bring the code to your machine without risking your `main` branch.
1. **Deactivate your virtual environment** (so Windows doesn't lock the files):
```bash
deactivate
```
2. **Fetch the Pull Request** (Replace `ID` with the PR number, and name the test branch something obvious):
```bash
git fetch origin pull/ID/head:test-pr-branch
```
3. **Switch to the test branch:**
```bash
git checkout test-pr-branch
```

### Phase 3: The Regression Test (In Terminal)
Prove that their new code doesn't break the existing features.
1. **Delete the old virtual environment** to ensure a totally clean test:
   * *Windows PowerShell:* `Remove-Item -Recurse -Force venv`
   * *Linux/Mac:* `rm -rf venv`
2. **Run your setup/installation scripts** to rebuild the environment with their new code.
3. **Run your application** (`python main.py ...`) and test the core functionality. Ensure it executes perfectly from start to finish.

### Phase 4: The Merge & The Reply (On GitHub)
Once the local test passes, make it official in the browser.
1. **Leave a comment:** Always thank the contributor, explicitly state that you tested it on your OS, and confirm it works. 
2. **Squash and Merge:** Click the dropdown arrow on the green Merge button and select **Squash and merge**. This condenses all their messy, incremental commits into one clean, professional commit for your project history.
3. **Delete the branch:** Click the prompt on GitHub to delete the PR branch from the remote server.

### Phase 5: Local Cleanup (In Terminal)
Sync your local machine with the newly updated GitHub repository and sweep away the testing clutter.
1. **Step off the test branch** and back to your main code:
```bash
git checkout main
```
2. **Download the newly merged code** from GitHub:
```bash
git pull origin main
```
3. **Delete the local test branch** (using the capital `-D` to force delete, since GitHub squashed the history):
```bash
git branch -D test-pr-branch
```
## Git Workflow Scenarios and Commands

### Start of Work Session
Always pull before touching anything.
```bash
git pull origin <branch>
```

### Ready to Commit Your Work
Stage, commit, pull to absorb other team's changes, then push.
```bash
git add <your files>
git commit -m "your message"
git pull origin <branch>
git push origin <branch>
```

### Pull Blocked — Unstaged Changes (Not Ready to Commit)
Stash your work, pull, then restore.
```bash
git stash
git pull origin <branch>
git stash pop
```

### Merge Conflict After Pull
Identify, resolve, then complete the merge.
```bash
git status # see conflicted files
# open conflicted files, resolve <<<< / ==== / >>>>
git add <resolved files>
git commit
git push origin <branch>
```

### Inspect Other Team's Changes Before Merging
Fetch without merging, review, then decide.
```bash
git fetch origin <branch>
git log HEAD..origin/<branch> --oneline
```