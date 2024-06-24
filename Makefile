install: backup-config install-nvim-config install-tpm install-tmux-config install-zsh-config

backup-config:
	@echo "\033[31mBacking up existing configurations...\033[0m"
	@if [ -d ~/.config/nvim/lua ]; then \
	    mkdir -p ~/.config/nvim/lua_backup; \
	    cp -R ~/.config/nvim/lua ~/.config/nvim/lua_backup; \
	    echo "\033[33mNeovim configuration backed up! 🗂\033[0m"; \
	fi
	@if [ -f ~/.tmux.conf ]; then \
	    cp ~/.tmux.conf ~/.tmux.conf.backup; \
	    echo "\033[33mTmux configuration backed up! 🗂\033[0m"; \
	fi
	@if [ -f ~/.zshrc ]; then \
	    cp ~/.zshrc ~/.zshrc.backup; \
	    echo "\033[33mZsh configuration backed up! 🗂\033[0m"; \
	fi

install-nvim-config:
	@echo "\033[34mInstalling Neovim configuration...\033[0m"
	@mkdir -p ~/.config/nvim/lua
	@cp -R lua/config ~/.config/nvim/lua/config
	@cp -R lua/plugins ~/.config/nvim/lua/plugins
	@echo "\033[36mNeovim configuration installed! 🎉\033[0m"

install-tpm:
	@echo "\033[32mInstalling TPM...\033[0m"
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null && echo "\033[34mTPM installed! 🔌\033[0m" || echo "\033[35mTPM already installed.\033[0m"

install-tmux-config:
	@echo "\033[35mConfiguring Tmux...\033[0m"
	@cp tmux/tmux.conf ~/.tmux.conf
	@echo "\033[35mTmux configured! 📝\033[0m"

install-zsh-config:
	@echo "\033[36mConfiguring Zsh...\033[0m"
	@cp .zshrc ~/.zshrc
	@echo "\033[31mZsh configured! 🐚\033[0m"

install-alacritty-config:
	@echo "\033[32mInstalling Alacritty configuration...\033[0m"
	@mkdir -p ~/.config/alacritty
	@cp dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
	@echo "\033[32mAlacritty configuration installed! 🚀\033[0m"

.PHONY: install backup-config install-nvim-config install-tpm install-tmux-config install-zsh-config

