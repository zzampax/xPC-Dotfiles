#!/bin/bash

# This script is used to fastly select a color out of the Catppuccin palette
# The palette will be saved in a JSON file in $HOME/.local/share/ctp/palette.json
# The list will update itself on keypress, and pressing enter will copy the selected color to the clipboard
# Usage:
# 	ctp
# 	Select a main theme (latte, frappe, macchiato, mocha)
#	Select a color from the list (every theme has the same color names but different values)
#	Press enter to copy the color to the clipboard
#	Press Ctrl+C to quit the script

# ####################
# # HANDLING SIGNALS #
# ####################
# The script will exit if the user presses q or Ctrl+C

# ####################
# # HANDLING OPTIONS #
# ####################

cleanup() {
    "Cleaning up..."
    exit 1
}

# Trap the cleanup function on Ctrl+C
trap cleanup SIGINT

# Check if the script is being run with parameters
# Handled parameters:
# --gen: generate the palette file
# --help: show the help message
# --version: show the version of the script
generate_palette=false
show_help=false
show_version=false

while [ "$1" != "" ]; do
	case $1 in
		--gen)
			generate_palette=true
			;;
		--help)
			show_help=true
			;;
		--version)
			show_version=true
			;;
		*)
			echo "Invalid parameter $1"
			exit 1
			;;
	esac
	shift
done

if [ "$show_help" = true ]; then
	echo "ctp - Catppuccin color picker"
	echo "Usage: ctp [OPTION]"
	echo "Options:"
	echo "	--gen	Generate the palette file"
	echo "	--help	Show this help message"
	echo "	--version	Show the version of the script"
	exit 0
fi

if [ "$show_version" = true ]; then
	echo "ctp version 1.2"
	exit 0
fi

if [ "$generate_palette" = true ]; then	
	if [ ! -d "$HOME/.local/share/ctp" ]; then
		mkdir -p "$HOME/.local/share/ctp"
	fi
	curl -s https://raw.githubusercontent.com/zzampax/Catppuccin-CLI-Color-Picker/main/palette.json -o "$HOME/.local/share/ctp/palette.json"
	echo "Palette file generated in $HOME/.local/share/ctp/palette.json"
	exit 0
fi

# ##############################
# # CHECK THE GRAPHICAL SERVER #
# ##############################

# Check if X11 or Wayland is being used
if [ -n "$WAYLAND_DISPLAY" ]; then
	clipboard_tool=wl-copy
elif [ -n "$DISPLAY" ]; then
	clipboard_tool=xclip
else
#	echo "No graphical server found, will not copy the color to the clipboard"
	cli_mode=true
fi
# ######################
# # CHECK DEPENDENCIES #
# ######################

# Dependecies:
# jq: to parse the JSON file
# xclip or wl-clipboard: to copy the color to the clipboard
# fzf: to select the color
missing_clipboard_tool=false
missing_jq=false
missing_fzf=false

if ! [ command -v $clipboard_tool &> /dev/null ] && ! [ cli_mode ]; then
	echo "Missind dependency: $clipboard_tool"
	missing_clipboard_tool=true
fi

if ! command -v jq &> /dev/null; then
	echo "Missing dependency: jq"
	missing_jq=true
fi

if ! command -v fzf &> /dev/null; then
	echo "Missing dependency: fzf"
	missing_fzf=true
fi

if [ "$missing_clipboard_tool" = true ] || [ "$missing_jq" = true ] || [ "$missing_fzf" = true ]; then
	exit 1
fi

# ####################
# # LOAD THE PALETTE #
# ####################

palette_file="$HOME/.local/share/ctp/palette.json"
if [ ! -f $palette_file ]; then
	echo "Palette file not found, please run ctp --gen to generate the palette"
fi

# ####################
# # SELECT THE THEME #
# ####################

# Setting the fzf colors to match the Catppuccin theme :D
export FZF_DEFAULT_OPTS=" \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

themes=$(jq -r 'keys[]' $palette_file)
selected_theme=$(echo "$themes" | fzf --layout reverse --prompt "Select a theme: ")

if [ -z "$selected_theme" ]; then
	exit 0
fi

# ####################
# # SELECT THE COLOR #
# ####################

# Get the colors of the selected theme
# The colors are in the format "color_name: color_value"
# The color value is in the format "#RRGGBB"
# The color name is the same for every theme

colors=$(jq -r ".$selected_theme | to_entries | .[] | .key + \": \" + .value" $palette_file)
selected_color=$(echo "$colors" | fzf --layout reverse --prompt "Select a color: ")

if [ -z "$selected_color" ]; then
	exit 0
fi


# ####################
# # COPY TO CLIPBOARD #
# ####################
# The color is in the format "color_name: color_value"
# We need to extract the color value and copy it to the clipboard
# The color value is in the format "#RRGGBB"

color_value=$(echo "$selected_color" | cut -d ":" -f 2 | xargs)
if ! [ $cli_mode ]; then
	echo -n "$color_value" | $clipboard_tool
	echo -e "Color copied to the clipboard:\n$selected_color"
else
	clear
	echo -e "Color selected:\n$selected_color"
fi

exit 0
