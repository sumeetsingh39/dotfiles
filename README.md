# dotfiles

Sumeet's dotfiles — EndeavourOS Sway / Catppuccin Mocha Lavender

## Setup

```bash
# Clone
git clone git@github.com:sumeetsingh39/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install stow
sudo pacman -S stow

# Symlink everything
stow zsh git sway waybar kitty dunst fuzzel nvim tmux ohmyposh ripgrep fastfetch gammastep mpv
```

## Packages

| Package    | Config path                  |
|------------|------------------------------|
| zsh        | ~/.zshrc                     |
| git        | ~/.gitconfig                 |
| sway       | ~/.config/sway/              |
| waybar     | ~/.config/waybar/            |
| kitty      | ~/.config/kitty/             |
| dunst      | ~/.config/dunst/             |
| fuzzel     | ~/.config/fuzzel/            |
| nvim       | ~/.config/nvim/              |
| tmux       | ~/.config/tmux/              |
| ohmyposh   | ~/.config/ohmyposh/          |
| ripgrep    | ~/.config/ripgrep/           |
| fastfetch  | ~/.config/fastfetch/         |
| gammastep  | ~/.config/gammastep/         |
| mpv        | ~/.config/mpv/               |

## Adding a new config

```bash
cd ~/dotfiles
mkdir -p <package>/.config/<app>
cp -r ~/.config/<app>/* <package>/.config/<app>/
stow <package>
git add . && git commit -m "add <app> config"
git push
```

## Stack

- **WM:** Sway
- **Bar:** Waybar
- **Terminal:** Kitty
- **Shell:** Zsh + zinit
- **Editor:** Neovim
- **Launcher:** Fuzzel
- **Notifications:** Dunst
- **Theme:** Catppuccin Mocha Lavender
