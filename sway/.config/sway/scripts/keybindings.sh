#!/bin/bash
# keybindings.sh - Searchable keybindings cheatsheet via fuzzel
# Place at ~/.config/sway/scripts/keybindings.sh
# Bind in sway: bindsym $mod+F1 exec ~/.config/sway/scripts/keybindings.sh
#
# Format: CATEGORY | KEY | DESCRIPTION
# Selecting an entry does nothing — it's reference only

BINDINGS=$(cat << 'EOF'
 SWAY — Basics        │  Mod+Return          │  Open terminal (kitty)
 SWAY — Basics        │  Mod+Q               │  Kill focused window
 SWAY — Basics        │  Mod+D               │  App launcher (fuzzel)
 SWAY — Basics        │  Mod+Shift+D         │  App menu (nwg-drawer)
 SWAY — Basics        │  Mod+Shift+C         │  Reload sway config
 SWAY — Basics        │  Mod+Shift+E         │  Power menu
 SWAY — Basics        │  Mod+F1              │  This cheatsheet
 SWAY — Basics        │  Mod+F1 (lock)       │  Lock screen (gtklock)
 SWAY — Focus         │  Mod+H/J/K/L         │  Focus left/down/up/right
 SWAY — Focus         │  Mod+Arrow keys      │  Focus left/down/up/right
 SWAY — Focus         │  Mod+Space           │  Toggle focus tiling/floating
 SWAY — Focus         │  Mod+A               │  Focus parent container
 SWAY — Focus         │  Mod+P               │  Window switcher (fzf)
 SWAY — Move          │  Mod+Shift+H/J/K/L   │  Move window left/down/up/right
 SWAY — Move          │  Mod+Shift+Arrows    │  Move window
 SWAY — Resize        │  Mod+Ctrl+H/J/K/L    │  Resize window
 SWAY — Resize        │  Mod+Ctrl+Arrows     │  Resize window
 SWAY — Layout        │  Mod+V               │  Split vertically
 SWAY — Layout        │  Mod+B               │  Split horizontally
 SWAY — Layout        │  Mod+S               │  Stacking layout
 SWAY — Layout        │  Mod+W               │  Tabbed layout
 SWAY — Layout        │  Mod+E               │  Toggle split layout
 SWAY — Layout        │  Mod+F               │  Fullscreen
 SWAY — Layout        │  Mod+Shift+Space     │  Toggle floating
 SWAY — Workspaces    │  Mod+1..0            │  Switch to workspace 1-10
 SWAY — Workspaces    │  Mod+Shift+1..0      │  Move window to workspace 1-10
 SWAY — Scratchpad    │  Mod+Shift+Minus     │  Send to scratchpad
 SWAY — Scratchpad    │  Mod+Minus           │  Show/cycle scratchpad
 SWAY — Apps          │  Mod+N               │  File manager (thunar)
 SWAY — Apps          │  Mod+O               │  Browser (firefox)
 SWAY — Clipboard     │  Mod+Ctrl+V          │  Clipboard picker
 SWAY — Clipboard     │  Mod+Ctrl+X          │  Delete clipboard entry
 SWAY — Screenshot    │  Print               │  Screenshot selection → swappy
 SWAY — Screenshot    │  Ctrl+Print          │  Screenshot window → swappy
 SWAY — Screenshot    │  Shift+Print         │  Screenshot display → swappy
 SWAY — Media         │  XF86AudioRaise      │  Volume up +5%
 SWAY — Media         │  XF86AudioLower      │  Volume down -5%
 SWAY — Media         │  XF86AudioMute       │  Toggle mute
 SWAY — Media         │  XF86AudioPlay       │  Play/pause
 SWAY — Media         │  XF86AudioNext       │  Next track
 SWAY — Media         │  XF86AudioPrev       │  Previous track
 SWAY — Media         │  XF86BrightnessUp    │  Brightness up +5%
 SWAY — Media         │  XF86BrightnessDown  │  Brightness down -5%
 ZSH — Navigation     │  cd <dir>            │  Smart cd with zoxide (learns habits)
 ZSH — Navigation     │  cl <dir>            │  cd + ls
 ZSH — Navigation     │  fcd                 │  Fuzzy directory picker
 ZSH — Navigation     │  mkcd <dir>          │  mkdir + cd
 ZSH — Navigation     │  .. / ... / ....     │  Go up 1/2/3 directories
 ZSH — Files          │  cat <file>          │  View file with bat (syntax highlighted)
 ZSH — Files          │  catp <file>         │  View file with bat + pager
 ZSH — Files          │  preview <file>      │  Full bat preview with decorations
 ZSH — Files          │  fv                  │  Fuzzy find file → open in nvim
 ZSH — Files          │  ff <name>           │  Find file by name with preview
 ZSH — Files          │  clip <file>         │  Copy file to Wayland clipboard
 ZSH — Files          │  bak <file>          │  Quick backup (adds .bak.YYYYMMDD)
 ZSH — Files          │  extract <file>      │  Extract any archive format
 ZSH — Search         │  rg <pattern>        │  Ripgrep search (colored)
 ZSH — Search         │  rgi <pattern>       │  Case-insensitive ripgrep
 ZSH — Search         │  rgl <pattern>       │  Show only filenames of matches
 ZSH — Search         │  frg <pattern>       │  Ripgrep + fzf → open match in nvim
 ZSH — History        │  Ctrl+R              │  Fuzzy search command history
 ZSH — History        │  Ctrl+P / Ctrl+N     │  Previous/next matching command
 ZSH — History        │  Up/Down arrows      │  History search by prefix
 ZSH — FZF            │  Ctrl+F              │  Fuzzy find files
 ZSH — FZF            │  Alt+C               │  Fuzzy cd into subdirectory
 ZSH — FZF            │  Ctrl+/              │  Toggle fzf preview pane
 ZSH — FZF            │  Ctrl+U / Ctrl+D     │  Scroll fzf preview up/down
 ZSH — FZF            │  Tab                 │  Multi-select in fzf
 ZSH — Misc           │  fkill               │  Fuzzy process killer
 ZSH — Misc           │  fh                  │  Fuzzy history search + run
 ZSH — Misc           │  note <text>         │  Save timestamped note
 ZSH — Misc           │  notes               │  View all notes
 ZSH — Misc           │  snote <pattern>     │  Search notes with fzf
 ZSH — Misc           │  path                │  Print PATH entries one per line
 ZSH — Misc           │  dus [depth]         │  Disk usage sorted by size
 ZSH — Misc           │  o <file>            │  Open with xdg-open
 ZSH — Vim mode       │  jk                  │  Exit insert → normal mode
 ZSH — Vim mode       │  w / b / e           │  Word forward/back/end
 ZSH — Vim mode       │  0 / $               │  Start/end of line
 ZSH — Vim mode       │  dd / cc             │  Delete/change whole line
 ZSH — Vim mode       │  ci" / ca(           │  Change inside/around delimiter
 ZSH — Vim mode       │  v                   │  Visual mode
 ZSH — Configs        │  zshrc               │  Edit ~/.zshrc
 ZSH — Configs        │  swayconfig          │  Edit sway main.conf
 ZSH — Configs        │  waybarconfig        │  Edit waybar config
 ZSH — Configs        │  waybarcss           │  Edit waybar style.css
 ZSH — Configs        │  kittyconfig         │  Edit kitty.conf
 ZSH — Packages       │  update              │  yay -Syu (full upgrade)
 ZSH — Packages       │  install <pkg>       │  yay -S
 ZSH — Packages       │  remove <pkg>        │  pacman -Rns (with deps)
 ZSH — Packages       │  search <pkg>        │  yay -Ss
 ZSH — Packages       │  orphans             │  List orphaned packages
 ZSH — Packages       │  autoremove          │  Remove all orphans
 ZSH — Sway           │  reload              │  Reload sway config
 ZSH — Systemd        │  sstart/sstop        │  systemctl start/stop
 ZSH — Systemd        │  srestart/sstatus    │  systemctl restart/status
 ZSH — Systemd        │  ustart/ustop        │  systemctl --user start/stop
 VIM — Modes          │  i / a               │  Insert before/after cursor
 VIM — Modes          │  I / A               │  Insert at line start/end
 VIM — Modes          │  o / O               │  New line below/above
 VIM — Modes          │  v / V               │  Visual / visual line
 VIM — Modes          │  Ctrl+V              │  Visual block
 VIM — Modes          │  Esc                 │  Back to normal mode
 VIM — Navigation     │  h/j/k/l             │  Left/down/up/right
 VIM — Navigation     │  w / b / e           │  Word forward/back/end
 VIM — Navigation     │  0 / ^ / $           │  Line start / first char / end
 VIM — Navigation     │  gg / G              │  File start / end
 VIM — Navigation     │  Ctrl+D / Ctrl+U     │  Half page down/up (centered)
 VIM — Navigation     │  { / }               │  Jump paragraph up/down
 VIM — Navigation     │  % (on bracket)      │  Jump to matching bracket
 VIM — Navigation     │  * / #               │  Search word under cursor fwd/bwd
 VIM — Edit           │  x                   │  Delete character
 VIM — Edit           │  dd / D              │  Delete line / to end of line
 VIM — Edit           │  cc / C              │  Change line / to end of line
 VIM — Edit           │  yy / Y              │  Yank (copy) line
 VIM — Edit           │  p / P               │  Paste after/before
 VIM — Edit           │  u / Ctrl+R          │  Undo / redo
 VIM — Edit           │  . (dot)             │  Repeat last change
 VIM — Edit           │  ~ (tilde)           │  Toggle case
 VIM — Text objects   │  ciw / caw           │  Change inner/around word
 VIM — Text objects   │  ci" / ca"           │  Change inside/around quotes
 VIM — Text objects   │  ci( / ca(           │  Change inside/around parens
 VIM — Text objects   │  ci{ / ca{           │  Change inside/around braces
 VIM — Text objects   │  dit / dat           │  Delete inside/around HTML tag
 VIM — Search         │  /pattern            │  Search forward
 VIM — Search         │  ?pattern            │  Search backward
 VIM — Search         │  n / N               │  Next/prev match
 VIM — Search         │  Esc                 │  Clear search highlight
 VIM — Splits         │  Space+sv            │  Vertical split
 VIM — Splits         │  Space+sh            │  Horizontal split
 VIM — Splits         │  Space+sc            │  Close split
 VIM — Splits         │  Ctrl+H/J/K/L        │  Navigate between splits
 VIM — Splits         │  Ctrl+Arrows         │  Resize splits
 VIM — Buffers        │  Shift+L / Shift+H   │  Next / prev buffer
 VIM — Buffers        │  Space+bd            │  Delete buffer
 VIM — File           │  Ctrl+S              │  Save (works in insert mode too)
 VIM — File           │  Space+q             │  Quit
 VIM — File           │  Space+Q             │  Quit all
 VIM — Macros         │  q<letter>           │  Record macro
 VIM — Macros         │  @<letter>           │  Play macro
 VIM — Macros         │  @@                  │  Replay last macro
 GIT — Status         │  git st              │  Short status with branch
 GIT — Status         │  git last            │  Show last commit
 GIT — Log            │  git lg              │  Pretty graph log (all branches)
 GIT — Log            │  git ll              │  Log with date and author
 GIT — Log            │  git today           │  Commits made today
 GIT — Log            │  git week            │  Commits this week
 GIT — Log            │  git contributors    │  List contributors by commits
 GIT — Stage          │  git aa              │  Add all (git add --all)
 GIT — Stage          │  git unstage <file>  │  Unstage a file
 GIT — Stage          │  git discard <file>  │  Discard working changes
 GIT — Commit         │  git gcm "msg"       │  git commit -m
 GIT — Commit         │  git wip             │  Quick wip commit of everything
 GIT — Commit         │  git unwip           │  Undo wip commit
 GIT — Commit         │  git undo            │  Undo last commit (keep changes)
 GIT — Branch         │  git gb              │  List branches
 GIT — Branch         │  git gba             │  List all branches (+ remote)
 GIT — Branch         │  git branches        │  All branches sorted by date
 GIT — Branch         │  git gco <branch>    │  Checkout branch
 GIT — Diff           │  git gd              │  Diff working tree
 GIT — Diff           │  git gds             │  Diff staged changes
 GIT — Diff           │  git gshow           │  Show commit with delta highlight
 GIT — Stash          │  git gst             │  Stash changes
 GIT — Stash          │  git gstp            │  Pop stash
 GIT — Stash          │  git stashes         │  List all stashes
 GIT — Remote         │  git gp              │  Push
 GIT — Remote         │  git gpl             │  Pull (rebases by default)
 GIT — Shorthand      │  git clone gh:u/r    │  Clone from GitHub shorthand
 GIT — Shorthand      │  git clone gl:u/r    │  Clone from GitLab shorthand
 FZF — In shell       │  Ctrl+R              │  Search command history
 FZF — In shell       │  Ctrl+F              │  Find files in current dir
 FZF — In shell       │  Alt+C               │  Fuzzy cd into subdirectory
 FZF — In fzf         │  Ctrl+/              │  Toggle preview pane
 FZF — In fzf         │  Ctrl+U / Ctrl+D     │  Scroll preview up/down
 FZF — In fzf         │  Tab                 │  Multi-select
 FZF — In fzf         │  Shift+Tab           │  Deselect
 FZF — In fzf         │  Enter               │  Confirm selection
 FZF — In fzf         │  Esc                 │  Cancel
 FZF — Functions      │  fv                  │  Find file → open in nvim
 FZF — Functions      │  fcd                 │  Fuzzy cd with eza preview
 FZF — Functions      │  frg <pattern>       │  Ripgrep → open match in nvim
 FZF — Functions      │  fkill               │  Fuzzy process killer
 FZF — Functions      │  fh                  │  Fuzzy history → run command
 FZF — Tab complete   │  cd <Tab>            │  Directory picker with eza preview
 FZF — Tab complete   │  nvim <Tab>          │  File picker with bat preview
 FZF — Tab complete   │  kill <Tab>          │  Process picker
EOF
)

# Show in fuzzel dmenu
SELECTED=$(echo "$BINDINGS" | fuzzel \
    --dmenu \
    --width=80 \
    --lines=15 \
    --prompt="  Search keybindings: " \
    --font="JetBrainsMono Nerd Font:size=11")

# Nothing happens on selection — it's a reference cheatsheet
# But we could extend this to e.g. run the command if it's a zsh alias
exit 0
