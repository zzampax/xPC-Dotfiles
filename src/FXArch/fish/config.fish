if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
function fish_prompt
    # Start with normal color
	echo -n (printf '\033[38;2;235;160;172m')
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

bind \cl ''

function ssh
    # Check if we are in the kitty terminal
    if test "$TERM" = "xterm-kitty"
        # Connect via SSH and immediately start tmux on the remote machine
        command tmux new-session "ssh $argv; exit"
    else
        # Just run the regular ssh command if not in kitty
        command ssh $argv
    end
end

# Aliases
alias g='git'
alias gback='git commit -m "Backup $(date +"%Y-%m-%d %H:%M:%S")"'
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -l'
alias l='ls -lA'
alias ip='ip -c'
alias tree='tree -C --dirsfirst'
alias fetch='clear && fastfetch'
alias sys='fastfetch'
alias localvenv='source .venv/bin/activate.fish'
