#!/bin/bash

# Ansi color code variables
# shellcheck disable=SC2034
red="\e[0;91m"
# shellcheck disable=SC2034
blue="\e[0;94m"
# shellcheck disable=SC2034
green="\e[0;92m"
# shellcheck disable=SC2034
white="\e[0;97m"
# shellcheck disable=SC2034
bold="\e[1m"
# shellcheck disable=SC2034
uline="\e[4m"
# shellcheck disable=SC2034
reset="\e[0m"

### This script is highly experimental at the moment, don't expect much out of it.

restart_gnome () {
	if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
	echo -e "${red}Wayland won't restart GNOME by default, please logout and enable the extensions yourself using the GNOME Extensions app!"
	elif [ "$XDG_SESSION_TYPE" == "x11" ]; then
	echo -e "${green}restarting GNOME...${reset}"
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting...")'
	sleep 5s
	echo -e "${green}GNOME restarted!${reset}"
	fi
}

if [ "" != "$ask" ]; then
	if [ "$ask" == "macos" ]; then
		sudo apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
		restart_gnome
		gnome-extensions disable zorin-menu@zorinos.com
		gnome-extensions disable zorin-taskbar@zorinos.com
		gnome-extensions enable zorin-dash@zorinos.com
		gnome-extensions enable zorin-hide-activities-move-clock@zorinos.com
		curl https://raw.githubusercontent.com/pecha2k2/Zorin-extra-Layouts/main/zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
	fi

	if [ "$ask" == "win11" ]; then
	    echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
		gnome-extensions disable zorin-dash@zorinos.com
		gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
		gnome-extensions enable zorin-taskbar@zorinos.com
		gnome-extensions enable zorin-menu@zorinos.com
		curl https://raw.githubusercontent.com/pecha2k2/Zorin-extra-Layouts/main/11-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
		curl https://raw.githubusercontent.com/pecha2k2/Zorin-extra-Layouts/main/11-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
	fi

	if [ "$ask" == "ubuntu"]; then
		sudo apt install gnome-shell-extension-zorin-dash -y
		echo -e "${green}Gnome will be restarted in 5 seconds...${reset}"
		restart_gnome
		gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
		gnome-extensions disable zorin-menu@zorinos.com
		gnome-extensions disable zorin-taskbar@zorinos.com
		gnome-extensions enable zorin-dash@zorinos.com
		curl https://raw.githubusercontent.com/pecha2k2/Zorin-extra-Layouts/main/ubuntu-zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
	fi

	if [ "$ask" == "winclassic" ]; then
	    echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
		gnome-extensions disable zorin-dash@zorinos.com
		gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
		gnome-extensions enable zorin-taskbar@zorinos.com
		gnome-extensions enable zorin-menu@zorinos.com
		curl https://raw.githubusercontent.com/pecha2k2/Zorin-extra-Layouts/main/classic-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
		curl https://raw.githubusercontent.com/pecha2k2/Zorin-extra-Layouts/main/classic-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
	fi

	if [ "$ask" == "popshell" ]; then
		echo -e "${red} heavily in-Beta, might not work as expected${reset}"
		echo -e "${red}THIS REPLACES GNOME DEFAULT KEYBOARD SHORTCUTS${reset}"
		read -r -p "Press [Enter] to continue, or [CTRL + C] to cancel."
		sudo apt install git node-typescript -y
		mkdir ~/.popshell
		cd ~/.popshell || exit
		git clone https://github.com/pop-os/shell.git 
		cd shell || exit
		make local-install
		restart_gnome
		gnome-extensions enable pop-shell@system76.com -q
		echo -e "${red}The Keybinds can be reset in settings > keybinds!${reset}"
		exit
	fi

	if [ "$ask2" == "noannoyance" ]; then 
		echo -e "${green}Downloading extension...${reset}"
		sudo -B apt install gnome-shell-extension-no-annoyance
		restart_gnome
		gnome-extensions enable noannoyance@sindex.com -q
	fi

	if [ "$ask2" == "tilingassistant" ];then
		echo -e "${green}Downloading Extension...${reset}"
		wget https://extensions.gnome.org/extension-data/tiling-assistantleleat-on-github.v23.shell-extension.zip
		unzip tiling-assistantleleat-on-github.v23.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/tiling-assistant@leleat-on-github/
		restart_gnome
		gnome-extensions enable tiling-assistant@leleat-on-github
		echo -e "${green}all done!${reset}"
	fi

	if [ "$ask2" == "caffeine" ]; then
		echo -e "${green}Downloading Extension...${reset}"
		wget https://extensions.gnome.org/extension-data/caffeinepatapon.info.v37.shell-extension.zip
		unzip caffeinepatapon.info.v37.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/caffeine@patapon.info
		restart_gnome
		gnome-extensions enable caffeine@patapon.info
		echo -e "${green}all done!${reset}"
	fi

	if [ "$ask2" == "blurmyshell" ]; then
		echo -e "${green}Downloading extension...${reset}"
		wget https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v22.shell-extension.zip
		unzip blur-my-shellaunetx.v22.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx/
		restart_gnome
		gnome-extensions enable blur-my-shell@aunetx
		echo -e "${green}all done!${reset}"
	fi

	if [ "$ask" == "unity" ];then 
		echo -e "${green}Downloading extension...${reset}"
		wget https://extensions.gnome.org/extension-data/unitehardpixel.eu.v59.shell-extension.zip
		unzip unitehardpixel.eu.v59.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/
		restart_gnome
		gnome-extensions disable zorin-dash@zorinos.com
		gnome-extensions disable zorin-menu@zorinos.com
		gnome-extensions disable zorin-taskbar@zorinos.com
		gnome-extensions enable unite@hardpixel.eu
		echo -e "${green}all done!${reset}"
	fi

	if [ "$ask" == "justperfection" ]; then
		echo -e "${green}Downloading extension...${reset}"
		wget https://extensions.gnome.org/extension-data/just-perfection-desktopjust-perfection.v16.shell-extension.zip
		unzip just-perfection-desktopjust-perfection.v16.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/
		restart_gnome
		gnome-extensions enable just-perfection-desktop@just-perfection
		echo -e "${green}all done!${reset}"
	fi
else
echo -e "${red}NO VARIABLE PROVIDED!${reset}"
echo "AVAILABLE VARIABLES:"
echo "win11, macos, ubuntu, winclassic, popshell, noannoyance, tilingassistant, caffeine"
echo -e "${green}Use them like this:${reset} ask=win11 $0"
exit 0
fi
