# Dotfiles

basic nvim , tmux and zsh config.

## Requirements

- Using [lazyvim](https://github.com/LazyVim/LazyVim) for nvm config and plugins.
- Using [catppuccin](https://github.com/catppuccin/catppuccin) for nvim and
  tmux color scheme.
- Using [TPM](https://github.com/tmux-plugins/tpm) form tmux plugins.

### Alacritty

- Install color scheme:

```sh
curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
```

- Config and shortcuts: `~/.config/alacritty/alacritty.yml`

```yaml
import = [
"~/.config/alacritty/catppuccin-mocha.toml"
]

[shell]
program= "/home/linuxbrew/.linuxbrew/bin/tmux"
args= ["new-session", "-A", "-s", "general"]

[env]
LANG = "en_US.UTF-8"
LC_CTYPE = "en_US.UTF-8"
TERM = "xterm-256color"

[font]
size = 11.0

[font.normal]
family = "FiraCode Nerd Font"
style = "Regular"

[keyboard]
bindings = [
{ key = "F11", action = "ToggleFullscreen" }
]
```

### Tmux

- You have to install [TPM](https:://github.com/tmux-plugins/tpm) first and
  copy `tmux.conf` to `~/.tmux.conf` modify the tmux.conf as you like and copy it:

```sh
mv tmux.conf ~/tmux/.tmux.conf
```

- Install the plugins with tpm:

```sh
yourprefix + I
```

### Zsh

- Move add `zshrc` to `~/.zshrc`:

```sh
 mv zshrc ~/.zshrc`
```

- Adapat it to your needs (root path, aliases, etc)

### Install Config On Linux

- Run the following command in your command line to install the config:
  This will also save up your current configs under `*.backup` before replacing them.

```sh
make install
```
