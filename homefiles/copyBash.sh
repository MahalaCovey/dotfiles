#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
BASHRC_SOURCE="$DOTFILES_DIR/.bashrc"
BASHRC_TARGET="$HOME/.bashrc"

# Backup existing .bashrc if it exists and is not already a symlink
if [ -f "$BASHRC_TARGET" ] && [ ! -L "$BASHRC_TARGET" ]; then
    BACKUP="$HOME/.bashrc.backup.$(date +%s)"
    echo "Backing up existing .bashrc to $BACKUP"
    mv "$BASHRC_TARGET" "$BACKUP"
fi

# Create symlink
echo "Creating symlink:"
echo "$BASHRC_TARGET -> $BASHRC_SOURCE"
ln -sf "$BASHRC_SOURCE" "$BASHRC_TARGET"

echo
echo "Setup complete."
echo "To apply the changes, reload your environment:"
echo "  source ~/.bashrc"
echo "or log out and log back in."
