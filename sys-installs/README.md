# About
installAnsible.sh downloads and installs Ansible. It ensures you run the bash script with sudo. Checks for apt, and makes sure the software does not already exist on the machine. 
# Citations
## Website 
-[rm -r](https://linuxize.com/post/remove-directory-linux/)
## Claude Prompt
```
Please write a Bash script for installing Ansible on Ubuntu Linux based on the following requirements.

Write a script that 
* checks the effective user id (EUID) - if running as `root` the script may proceed, otherwise it exits and prompts the user that this script requires `sudo` or `root`
* checks that the system package manager is `apt` (or `apt` is available on the system), otherwise it exits and prompts the user that this script uses the `apt` package manager
* provides the user with information on what will be installed - allows the user to provide `y` for yes and proceeds or `n` for no and exits
* checks if name of software or software (not each of its dependencies) exists - exits if software is found (or if software name is taken) and prompts the user that a name conflict occurred
   * ex. Let's say `aws` is a command that exists and outputs `You're awesome!` - but it isn't the `aws` tool you are about to install. Since the program name is already taken, your install would fail before accidentally changing system behavior
* silently installs the software selected per instructions
   * ex. `sudo apt install apache2` will prompt me `y` / `n` before proceeding; `sudo apt install -y apache2` will assume "yes" as answer to all prompts and run non-interactively
* prompts the user that install is complete and a command to run to try it
```
