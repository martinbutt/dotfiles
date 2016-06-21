# Path to your oh-my-zsh installation.
export ZSH=/Users/martin.butt/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="martin-dark"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew-cask brew composer cp docker-compose history man redis-cli rsync screen ssh-agent)

# User configuration

export PATH="/usr/local/php5/bin:/user/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/martin.butt/pear/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

EDITOR=vim
PATH=/user/local/bin:$PATH
export PATH=/usr/local/php5/bin:$PATH

## Aliases
alias phpunit="php phpunit.php --verbose --colors"
alias py="python"
alias tac='tail -r'
alias clear-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias updatedb="sudo -u martin /usr/libexec/locate.updatedb"
alias grep="grep --colour=auto"
alias mkdir='mkdir -pv'
alias mount='mount |column -t'
alias path='echo -e ${PATH//:/\\n}'
alias su='sudo -i'
alias git-undo-commit='git reset --soft '\''HEAD^'\'''
alias git-kaboom="git reset --hard HEAD && git checkout . && git clean -f" #Kills all local changes and takes repo back to original state
alias docker-env='eval "$(docker-machine env default)"'

eval $(docker-machine env default)

unsetopt share_history

ssh() {
	if [ "$1" = "staging" ]; then
		TERM_TEXT_COLOR="Green";
	elif [ "$1" = "worker" ]; then
		TERM_TEXT_COLOR="Red";
	else
		TERM_TEXT_COLOR="Blue";
	fi

	echo "tell app \"Terminal\" to set current settings of first window to settings set \"Martin Dark ${TERM_TEXT_COLOR}\"" | osascript;
	/usr/bin/ssh "$@";
	echo "tell app \"Terminal\" to set current settings of first window to settings set \"Martin Dark Yellow\"" | osascript;
}
