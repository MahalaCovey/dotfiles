# Files
`.basrc` provides aliases for easily traversal by replacing cd .., cd ..., etc with .., ... etc.  
`copyBash.sh` is a script that symbolically links my `.bashrc` file in my dotfiles repository to my user's home directory.

# Citations
## Websites
- [:q! used from article](https://www.geeksforgeeks.org/linux-unix/how-to-exit-vim/)

## ChatGPT
- Prompt: How do I edit my bash file to have alases? alias .="cd .." alias ..="cd ../.." alias ...="cd ../../.." alias ....="cd ../../../.." alias .....="cd ../../../../.."  
ChatGPT provided instructions on how to edit my bashrc file with the aliases in Nano.

- Prompt: I'm using Vim  
ChatGPT provided instructions on how to edit my bashrc file with the aliases in Vim.

- Prompt: How do I copy the baschrc file to my dotfiles repo?  
ChatGPT provided me with the "cp ~/.bashrc ." command.

- Prompt: How do I create a script that does this? copies or symbolically links the .bashrc file in your dotfiles repository to your user's home directory yes, this means getting rid of, or better, moving (renaming) the original as a backup, and having the sym link named ~/.bashrc be in its place  
ChatGPT provided me with the script.

- Prompt: remind (prompt) the user to reload their environment (with source or by logging out and back on)  
ChatGPT added the prompt to the script.


