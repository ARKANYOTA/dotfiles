DOTFILE_PATH = /home/ay/dotfiles
HOME = /home/ay
##########################
#      YAY             #
##########################
yay:
	echo "INSTALL YAY"

yay-packages:
	yay -Sy kitty ttf-fira-code brave vim zsh zsh-completions zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k feh pulseaudio

yay-useless-package:
	yay -S libreoffice-fresh-fr

yay-packages-arch:
	yay -S picom nitrogen dmenu 

yay-divers-arch:
	yay -S alsa-utils

##########################
#      CONFIG          #
##########################
i3-config:
	ln -sf "$(DOTFILE_PATH)/config/i3wm" "/home/ay/.config/i3/config"
picom-config:
	ln -sf "$(DOTFILE_PATH)/config/picom" ~/.config/picom.conf
git-config:
	ln -sf "$(DOTFILE_PATH)/config/gitconfig" ~/.gitconfig

kitty-config:
	ln -sf "$(DOTFILE_PATH)/config/kitty.conf" ~/.config/kitty/kitty.conf
	ln -sf "$(DOTFILE_PATH)/config/kitty-themes" ~/.config/kitty/kitty-themes

vim-config:
	ln -sf "$(DOTFILE_PATH)/config/vimrc" ~/.vimrc
	rm -rf ~/.vim
	ln -sf "$(DOTFILE_PATH)/config/vim" ~/.vim

zsh-config:
	ln -sf "$(DOTFILE_PATH)/config/zshrc" ~/.zshrc
	# wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	sh "$(DOTFILE_PATH)/install.sh"

ranger-config:
	rm -rf ~/.config/ranger
	ln -sf "$(DOTFILE_PATH)/config/ranger" ~/.config/


background-config:
	# nitrogen --set-auto "$(DOTFILE_PATH)/background/arkanyota-logo/AY_3D_4K_dark.png"
	nitrogen "$(DOTFILE_PATH)/background/arkanyota-logo/"

make-config: git-config kitty-config background-config vim-config ranger-config

##########################
#      GRUB            #
##########################

theme-grub:
	@echo "change GRUB_THEME path with your home directory"
	sudo ln -sf $(DOTFILE_PATH)/grub/etc-default-grub /etc/default/grub
	sudo grub-mkconfig -o /boot/grub/grub.cfg

##########################
#      KEYBOARD        #
##########################



##########################
#      ALL             #
##########################
all: yay yay-packages make-config theme-grub 
