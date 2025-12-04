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

## Add SSH Keys to GitHub

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
cat ~/.ssh/id_ed25519.pub
```
Select and copy the entire output.

6. **Add SSH Key to GitHub**  
   * Go to your GitHub account settings: Settings > SSH and GPG keys.  
   * Click "New SSH key"  
   * Give your key a title and paste the copied public key.  
   * Click "Add SSH key"  

7.  **Test the Connection** 

```bash 
ssh -T git@github.com
```
You should see a success message.