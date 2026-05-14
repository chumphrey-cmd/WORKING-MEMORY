# Setting Up IDE (VSCode)

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

# IntelliJ Troubleshooting

* I ran into a problem where I was trying to coordinate the dependencies within the front and backend `pom.xml` files so that whenever you migrate to a new workspace, you can initiate a new project.
* Whenever I opened or cloned a new project, none of files were being recognized due to maven dependencies not initializing.

## 1. Set Up the Correct Repository Structure

```
root/
├── pom.xml                      ← root aggregator (coordinates between front and backend)
├── backend/
│   └── pom.xml                  ← backend module (backend dependencies)
└── frontend/
    └── pom.xml                  ← frontend module
```

## 2. Create Root `pom.xml` (Aggregator)

This file must be created manually at the repo root. It does **not** contain any dependencies — its only job is to declare the child modules.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>4.0.5</version>
    </parent>

    <groupId>io.chumahumphrey.qagen</groupId>
    <artifactId>qa-gen-backend</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>qa-gen-root</name>
    <description>qa-gen-backend</description>
    <packaging>pom</packaging>

    <modules>
        <module>backend-folder</module>
        <module>frontend-folder</module>
    </modules>
   
   <dependencies>
      ...
   </dependencies>

</project>
```

> [!NOTE]
> `<packaging>pom</packaging>` is mandatory. Without it, Maven treats the root as a compiled artifact and the module import fails.

## 3. Backend `pom.xml` (Child Module)

The backend **`pom.xml`** stays in the **`backend/`** folder. We only need to add a **`<parent>`** block pointing up to the root aggregator via a relative path.

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>4.0.5</version>
    <relativePath>../pom.xml</relativePath>
</parent>
```
> [!NOTE]
> The `<relativePath>../pom.xml</relativePath>` tells Maven to look one directory up for the parent.

