if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
function fish_prompt
    # Start with normal color
	echo -n (printf '\033[38;2;180;190;254m')
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

# Bind F9 to Right Arrow
bind \e\[20\~ backward-char
# Bind F10 to Left Arrow
bind \e\[21\~ forward-char
# Unbind Ctrl+L to Clear-Terminal (Kitty bug)
bind \cl ''

if test -n "$ZED_TERMINAL"
    ls -lA
end

# Utility Aliases
alias g='git'
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -l'
alias l='ls -lA'
alias vim='nvim'
# Pretty Aliases
alias ip='ip -c'
alias tree='tree -C --dirsfirst'
alias fetch='clear && fastfetch'
alias pretty='kitty -o initial_window_height=450 -o initial_window_width=700 --class kittyFloat --hold fastfetch & disown'
# Misc Aliases
alias lvenv='source .venv/bin/activate.fish'
alias kssh='kitten ssh'
