EDITOR=vim

## Start SSH agent

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
        . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi

## Aliases
alias phpunit="php phpunit.php --verbose --colors"
alias py="python"
alias tac='tail -r'
alias clear-dns='sudo discoveryutil udnsflushcaches'
alias updatedb="sudo -u martin /usr/libexec/locate.updatedb"
alias grep="grep --colour=auto"
alias mkdir='mkdir -pv'
alias mount='mount |column -t'
alias path='echo -e ${PATH//:/\\n}'
alias su='sudo -i'
alias git-undo-commit='git reset --soft '\''HEAD^'\'''
alias git-kaboom="git reset --hard HEAD && git checkout . && git clean -f" #Kills all local changes and takes repo back to original state
alias clear-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias docker-env='eval "$(docker-machine env default)"'

eval "$(docker-machine env default)"

## Functions
dos2unix(){
  tr -d '\r' < "$1" > t
  mv -f t "$1"
}

unix2dos(){
  sed -i 's/$/\r/' "$1"
}

sqlc(){
	echo "$1" | mysql -u root -D $2;
}
