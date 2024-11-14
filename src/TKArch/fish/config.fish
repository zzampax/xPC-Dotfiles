if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
function fish_prompt
    # Start with normal color
	echo -n (printf '\033[38;2;166;227;161m')
    # Print the user@host:pwd$ prompt
    echo -n "["(whoami)"@"(cat /etc/hostname)":"(prompt_pwd)"\$] "
    # Reset the color
    echo -n (printf '\033[0m')
end

# If local/bin not empty, add to path  
if test -d ~/.local/bin
    set -gx PATH ~/.local/bin $PATH
end
# If local/appimage not empty, add to path
if test -d ~/.local/appimage
    set -gx PATH ~/.local/appimage $PATH
end

# Aliases
alias g='git'
alias ll='ls -l'
alias l='ls -lA'
alias ip='ip -c'
alias tree='tree -C --dirsfirst'
alias fetch='clear && fastfetch'
alias vim='nvim'
alias localvenv='source .venv/bin/activate.fish'

# Remove the bind clear-screen
bind \cl ''

if [ "$ZED_TERMINAL" = "1" ];
	fastfetch -c screenfetch.jsonc -l small
end
