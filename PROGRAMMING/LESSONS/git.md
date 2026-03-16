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

---

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

I’ve updated your guide with the "bulletproof" additions. I modified the `includeIf` syntax to use the case-insensitive flag (`gitdir/i:`) and added a dedicated step for the SSH agent, which is the most common "gotcha" in this process.

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