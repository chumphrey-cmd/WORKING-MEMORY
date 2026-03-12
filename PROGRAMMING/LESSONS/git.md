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