#!/bin/zsh

# Update .zshrc with alias
alias_lines=(
  "alias opacity='~/Tools/Custom/Bash/config_editor/alacritty/opacity/opacity.sh'"
)

# To ensure the last line of ~/.zshrc is empty
ensure_last_line_empty() {
  if [ -n "$(tail -n 1 ~/.zshrc)" ]; then
    echo "" >> ~/.zshrc
  fi
}

ensure_last_line_empty

# Iterate over each alias line and check if it exists in ~/.zshrc
for alias_line in "${alias_lines[@]}"; do
  if ! grep -q "^$alias_line" ~/.zshrc; then
    # If not, append the alias line to ~/.zshrc
    echo "$alias_line" >> ~/.zshrc
    # echo "Alias added to ~/.zshrc: $alias_line"
  # else
    # echo "Alias already exists in ~/.zshrc: $alias_line"
  fi
done
