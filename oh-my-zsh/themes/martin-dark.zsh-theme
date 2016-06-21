# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(custom_git_prompt_info)'

custom_git_prompt_info() {
	if git status &>/dev/null; then
                git rev-parse --verify HEAD >/dev/null || exit 1
                git update-index -q --ignore-submodules --refresh
        	current_branch=$(git branch 2>/dev/null | grep "^\*" | cut -d ' ' -f 2 );
        
                if ! git diff-files --quiet --ignore-submodules
                then
                        #Unstaged changes
        		echo -n "[%{$fg[red]%}${current_branch}%{$reset_color%}]"
        		exit
                fi
        
                if ! git diff-index --cached --quiet --ignore-submodules HEAD --
                then
        		#Uncommited changes
        		echo -n "[%{$fg[blue]%}${current_branch}%{$reset_color%}]"
        		exit
                fi
        
        	echo -n "[%{$fg[green]%}${current_branch}%{$reset_color%}]"
	fi
}

# Return code
local return_code_info='$(return_code_prompt_info)'
return_code_prompt_info() {
	if [[ "$?" == "0" ]]; then
		echo -n "🙂 ";
	else
		echo -n "😡 ";
	fi
}

PROMPT="
${return_code_info}\
[%{$fg[white]%}%T%{$reset_color%}]\
%{$reset_color%}[\
%{$fg[blue]%}%n\
%{$reset_color%}@\
%{$fg[cyan]%}$(box_name)\
%{$reset_color%}:\
%{$fg[magenta]%}${current_dir}\
%{$reset_color%}]\
${git_info} "

if [[ "$USER" == "root" ]]; then
PROMPT="
${return_code_info}\
[%{$fg[white]%}%T%{$reset_color%}]\
%{$reset_color%}[\
%{$fg[blue]%}%n\
%{$reset_color%}@\
%{$fg[red]%}$(box_name)\
%{$reset_color%}:\
%{$fg[magenta]%}${current_dir}\
%{$reset_color%}]\
${git_info} "
fi
