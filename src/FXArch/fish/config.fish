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

# Aliases
alias g='git'
alias ll='ls -l'
alias l='ls -lA'
alias ip='ip -c'
alias fetch='clear && fastfetch'
alias pretty='clear;fastfetch;echo -e "\n\033[38;2;180;190;254m------------------------------------------------------------------------------------------\033[0m\n";ll ~;echo -e "\n\033[38;2;180;190;254m------------------------------------------------------------------------------------------\033[0m\n";ip a;echo -e "\n"'
alias sys='fastfetch'
alias localvenv='source .venv/bin/activate.fish'

if [ "$ZED_TERMINAL" = "1" ];
	fastfetch -c screenfetch.jsonc -l small
end
