global:
	ln -sf ~/dotfiles/globals/gitconfig ~/.gitconfig
theme-grub:
	@echo "change GRUB_THEME path with your home directory"
	sudo ln -sf ~/dotfiles/grub/etc-default-grub /etc/default/grub
	sudo grub-mkconfig -o /boot/grub/grub.cfg
i3wm-v1: global
	ln -sf ~/dotfiles/i3wm.v1/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
	echo "change export ZSH path with your home directory"
	ln -sf ~/dotfiles/i3wm.v1/config/zsh/zshrc ~/.zshrc
	ln -sf ~/dotfiles/i3wm.v1/config/picom/picom.conf ~/.config/picom.conf

i3wm-v2: global
	echo "global"
setup-keyboard:
	sudo ln -sf ~/dotfiles/keyboard/ay /usr/share/X11/xkb/symbols/ay

set-firacode:
	sudo mkdir -p /usr/share/fonts/TTF
	sudo ln -sf ~/dotfiles/font/* /usr/share/fonts/TTF/

ani-cli:
	mkdir -p ~/Apps
	curl https://raw.githubusercontent.com/pystardust/ani-cli/master/ani-cli >> ~/Apps/ani-cli
	sudo chmod 755 ~/Apps/ani-cli


