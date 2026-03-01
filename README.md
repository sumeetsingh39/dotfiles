# dotfiles

Sumeet's dotfiles — EndeavourOS Sway / Catppuccin Mocha Lavender

---

## Setup on a new machine

```bash
# 1. Install stow
sudo pacman -S stow

# 2. Clone the repo
git clone git@github.com:sumeetsingh39/dotfiles.git ~/dotfiles

# 3. Symlink everything
cd ~/dotfiles
stow zsh git sway waybar kitty dunst fuzzel nvim tmux ohmyposh ripgrep fastfetch gammastep mpv bin

# 4. Install the dots helper
chmod +x ~/.local/bin/dots
```

> **Note:** If any target file already exists (not a symlink), stow will conflict.
> Remove the original first: `rm ~/.config/<app>` then re-run stow.

---

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
| bin        | ~/.local/bin/                |

---

## dots helper commands

`dots` is a helper script at `~/.local/bin/dots` that wraps common dotfile operations.

| Command | Does |
|---|---|
| `dots push` | Commit + push all changes with auto timestamp |
| `dots push "message"` | Commit + push with custom message |
| `dots pull` | Pull latest from GitHub |
| `dots status` | Show changed files + list stowed packages |
| `dots add <pkg> <path>` | Add a new config to dotfiles |
| `dots list` | List all stowed packages |
| `dots restow` | Restow all packages |

---

## Common workflows

### Editing an existing config

Since files in `~` are symlinks pointing to `~/dotfiles/`, you can edit directly
in the dotfiles folder and changes are live immediately — no restow needed:

```bash
nvim ~/dotfiles/sway/.config/sway/config.d/main.conf
# ~/.config/sway/config.d/main.conf is already updated via symlink

dots push "update sway gaps"
```

### Adding a file to an existing package

Copy the new file into the package, remove the original, then restow:

```bash
cp ~/.local/bin/newscript ~/dotfiles/bin/.local/bin/
rm ~/.local/bin/newscript
cd ~/dotfiles && stow --restow bin
dots push "add newscript to bin"
```

### Adding a completely new config

Use `dots add` — it handles everything automatically (copy, remove original, stow, push):

```bash
dots add rofi .config/rofi
```

For a single file instead of a folder:
```bash
dots add somecfg .config/somecfg.conf
```

### Removing a config from dotfiles

Unstow the package (removes symlinks), then delete it from dotfiles:

```bash
cd ~/dotfiles
stow --delete <package>        # removes symlinks from ~
rm -rf ~/dotfiles/<package>    # remove from dotfiles
dots push "remove <package>"
```

> The actual config files are gone with the symlinks. If you want to keep
> using the app, copy the config back manually after unstowing:
> `cp -r ~/dotfiles/<package>/.config/<app> ~/.config/<app>`
> Do this BEFORE deleting the package from dotfiles.

### Pulling updates on an existing machine

```bash
dots pull
dots restow    # recreates any new symlinks added in the repo
```

### Checking what's tracked vs what's live

```bash
dots status                          # shows git changes + stowed packages
ls -la ~/.config/sway/               # symlinks point to ~/dotfiles/sway/...
readlink ~/.zshrc                    # shows where symlink points
```

---

## Stack

- **OS:** EndeavourOS
- **WM:** Sway
- **Bar:** Waybar
- **Terminal:** Kitty
- **Shell:** Zsh + zinit + vim mode
- **Editor:** Neovim
- **Launcher:** Fuzzel
- **Notifications:** Dunst
- **Theme:** Catppuccin Mocha Lavender
- **Dotfiles:** GNU Stow
