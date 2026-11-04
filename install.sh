#!/usr/bin/env bash
# Symlink dotfiles into $HOME. GitHub Codespaces runs this automatically
# when this repo is set as your dotfiles repo.
#
# If ~/.gitconfig is already a real file (Codespaces writes one before this
# runs), it's moved to ~/.gitconfig.local, which .gitconfig includes, so any
# settings in it are kept.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  if [ -e "$HOME/.gitconfig.local" ]; then
    cat "$HOME/.gitconfig" >> "$HOME/.gitconfig.local"
    rm "$HOME/.gitconfig"
  else
    mv "$HOME/.gitconfig" "$HOME/.gitconfig.local"
  fi
  echo "Moved existing ~/.gitconfig into ~/.gitconfig.local"
fi

for f in .gitconfig .gitconfig-private; do
  ln -sfn "$DOTFILES/$f" "$HOME/$f"
  echo "Linked ~/$f -> $DOTFILES/$f"
done
