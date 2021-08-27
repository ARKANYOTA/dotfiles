DOTFILE_PATH = /home/ay/dotfiles
##########################
#      YAY             #
##########################
yay:
	echo "INSTALL YAY"

yay-packages:
	yay -Sy kitty nerd-fonts-fira-code brave vim zsh zsh-completions zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting zsh-theme-powerlevel10k feh pulseaudio

##########################
#      CONFIG          #
##########################
i3-config:
	ln -sf "$(DOTFILE_PATH)/config/i3wm" ~/.i3/config
git-config:
	ln -sf "$(DOTFILE_PATH)/config/gitconfig" ~/.gitconfig

kitty-config:
	ln -sf "$(DOTFILE_PATH)/config/kitty.conf" ~/.config/kitty/kitty.conf
	ln -sf "$(DOTFILE_PATH)/config/kitty-themes" ~/.config/kitty/kitty-themes

vim-config:
	ln -sf "$(DOTFILE_PATH)/config/vimrc" ~/.vimrc

zsh-config:
	ln -sf "$(DOTFILE_PATH)/config/zshrc" ~/.zshrc

background-config:
	# nitrogen --set-auto "$(DOTFILE_PATH)/background/arkanyota-logo/AY_3D_4K_dark.png"
	nitrogen "$(DOTFILE_PATH)/background/arkanyota-logo/"

make-config: git-config kitty-config background-config vim-config

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
