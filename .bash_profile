#set -x
##

# Finished adapting your PATH environment variable for use with MacPorts.

export PERL5LIB="$HOME/SourceCache/bioperl-live"
#:$PERL5LIB"

# Choose Default editor
export VISUAL=emacs
export EDITOR="$VISUAL"
source ~/.functions.sh
source ~/.profile
#source ~/.bashrc

####################
# Alias / var exports
####################

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
#alias rm='echo "rm is disabled, use trash or /bin/rm instead/."'
export LS_OPTS='-lah --color=auto'
alias ls="ls $LS_OPTS"
#alias ls='ls -l -h'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'


alias today="date -I"
alias now="date -Iseconds | sed 's/\ /_/g' | sed 's/\:/-/g' | sed 's/-04-00//g'"
alias stayon="xset -dmps"
alias diskspace="du -S | sort -n -r |more"
alias grabcrons='journalctl -xe | grep CRON'
#alias deactivatepyenv="PATH=`echo $PATH | tr ':' '\n' | sed '/pyenv/d' | tr '\n' ':' | sed -r 's/:$/\n/'`"
#alias deactivatepyenv="PATH=`echo $PATH | tr ':' '\n' | sed '/pyenv/d' | tr '\n' ':' | sed -r 's/:$/\n/'`"

# Shows even more permissions
lsd () {
    ls -adlF "$@" | grep /$
}
lsf () {
    ls -alF "$@" | grep -v /$
}
remove_bell () {
    export BELL=0;
}


function chkplz () {
    find $1 -type f -exec md5sum {} + | grep "^$2"
}

function knit() {
    R -e "rmarkdown::render('$1', pdf_document(), params=list())"
} # M-x polymode-set-exporter while in poly-markdown+r-mode

function rsync_develop() {
    rsync -vrltA /develop/projects /ffast/matt/prj
}

function friendlyrsync() {
    if [ ${2: -1} == "/" ];
    then
       # https://stackoverflow.com/q/17542892 (C) CC-5.0
	   rsync -vrltAUt $1 $2
    else
	echo "FATAL ERROR: Did you forget youre trailing backslashes?"
    fi
}

alias ll='ls -h ${LS_OPTS}'
#Shows hidden files such as bashrc
alias la='ls -A'
#shows permissions
alias l='ls -CFlh'

alias create-patchfile="diff -uNr" #<orig> <new>
alias cmus='cmus --listen 0.0.0.0'

alias grep='grep --color=auto'
#alias psgrep='ps aux | grep'
alias please='sudo $(history -p \!\!)'

alias switch_control='setxkbmap -option caps:ctrl_modifier'

alias RELOAD=". ~/.bash_profile"
alias REMAP="xmodmap ~/.xmodmap"
alias sortbysize="ls -s | sort -n" # Sorts files by size
alias topcommands="echo 'Top commands:' && history | tr -s ' ' | cut -d ' ' -f 3 | sort | uniq -c | sort -n -r"

# COLORS!!
export TERM=xterm-256color
export GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

export UC=$COLOR_YELLOW               # user's color
[ $UID -eq "0" ] && export UC=$COLOR_RED   # root's color

# A W S
#export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.1
export EC2_URL=https://ec2.us-east-1.amazonaws.com

####################
# P A T H
####################

# P A T H
reset_path # See .functions.sh for details

# NVIDIA CUDA
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib/:/usr/x86_64-linux-gnu/lib/:/usr/local/lib:$LD_LIBRARY_PATH
#export LDFLAGS='-L/usr/lib'
#export CFLAGS=/usr/include/x86_64-linux-gnu/openssl
####################
# L a n g u a g e s
####################

# rust
# ---------------------
PATH=$PATH:$HOME/.cargo/bin
. "$HOME/.cargo/env"

# P Y T H O N
# --------------------
# Additional system-specific pyenv commands below
if [ $(hostname) == "argo" ] || [ $(hostname) == "Dend3" ] || [ $(hostname) == "wei" ];
then
   export PYENV_ROOT=$HOME/.pyenv
   PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH
   eval "$(pyenv init -)"
   eval "$(pyenv virtualenv-init -)"

fi

# L a T e X
if [ $(hostname) == "argo" ] || [ $(hostname) == "Dend3" ];
then
    PATH=$PATH:/usr/local/texlive/2025/bin/x86_64-linux
fi

# JAVA (for Neo4j)
#JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
#PATH="/usr/lib/jvm/jdk-11.0.8/bin:$PATH"

# node.js
# ---------------------

# NVM (node version manager)
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Terminal prompt
export PS1="$($HOME/.gitmode.sh --start)"
##export PS1="\[${UC}\]\u@\h: \[${COLOR_GREEN}\]\$($HOME/.gitmode.sh --start)| \[${COLOR_LIGHT_CYAN}\]\w >"

#PS1="$TITLEBAR\n\[${UC}\]\u \[${COLOR_LIGHT_BLUE}\]\${PWD} \[${COLOR_BLACK}\]\$(gitmode --start) \n\[${COLOR_LIGHT_GREEN}\]→\[${COLOR_NC}\] "

# R U B Y
export RVM=$HOME/.rvm
# In .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#ruby_version="ruby-3.3.7"
ruby_version=$(rvm list default string)
export RUBY=$RVM/rubies/$ruby_version/bin
#export RUBY_GEMS=$RVM/gems/$ruby_version/bin
export GEM_HOME=$RVM/gems/$ruby_version
export PATH=$GEM_HOME/bin:$RUBY:$PATH
#export RSENSE_HOME=$HOME/pckges/rsense-0.3


####################
# Ricing
####################
# if [ $(hostname) == "argo" ];
# then
#     powerline-daemon -q
#     POWERLINE_BASH_CONTINUATION=1
#     POWERLINE_BASH_SELECT=1
#     . /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
# fi

####################
# Databases
####################
#export PGDATA=/usr/local/pgsql/data
if [ $(hostname) == "argo" ];
then
    export PGDATA=/ffast/db/data
fi

####################
## Completions
####################
# Amazon Web Services
complete -C aws_completer aws
source /usr/share/bash-completion/completions/systemctl

####################
## Other
####################

# NCBI/Entrez utilities
# Download SRA-tools binaries
# Download Entrez Direct https://www.ncbi.nlm.nih.gov/books/NBK179288/
#PATH=$PATH:$HOME/edirect

# Refgenie
export REFGENIE=/ffast/assemblies/refgenie/genomes.yml

####################
## export PATH
####################
#export PATH=$PATH

####################
## System-specific
####################

# ASCII Owl and friends

if [ $(hostname) == "argo" ];
then
    #bash $HOME/.profile.sh
    neofetch
    lolcat $HOME/motd
    lolcat $HOME/.asciiowl.txt
    
    grep -A 12 "affirmations" /develop/repos/journal/journal_templates/template_daily_journal.md
    
    echo "Grep process: $?"

    xmodmap ~/.xmodmap
    # Other bash environment variables
    export TMPDIR=/tmp
    #export TMP=$TMPDIR
    #export TEMP
elif [ $(hostname) == "end4" ] || [ $(hostname) == "endurance" ];
then

    neofetch
    lolcat $HOME/motd
    lolcat $HOME/.asciiowl.txt

    # Uses Rust crate 'bat'
    grep -A 12 "affirmations" /develop/repos/journal/journal_templates/template_daily_journal.md | bat -P --style plain -l md --file-name "You can do this!"

    # Traditional x11 keybinding switch caps-lock -> ctrl
    #xmodmap ~/.xmodmap

    # Wayland Caps Lock switch
    # No longer used. Use input-remapper-gtk
    # See https://github.com/sezanzeb/input-remapper/blob/HEAD/readme/usage.md
    setxkbmap -option caps:ctrl_modifier

    # CUDA / AUTODOCK-VINA
    # find / -type d -name 'cuda*' 2> /dev/null
    export GPU_INCLUDE_PATH=/usr/lib/x86_64-linux-gnu/cuda-gdb
    export GPU_LIBRARY_PATH=/usr/include/cuda-gdb

    # sudo tune2fs -O ^has_journal /dev/sda4 # Remove journaling from volume
    # xset -dpms # turn-off energy star settings to prevent screen timeout

    #export PATH=$GEM_HOME/bin:$RUBY:$PATH
    # Other bash environment variables
    export TMPDIR=/mnt/tmp
elif [ $(hostname) == "wei" ];
then
    /usr/local/bin/lolcat $HOME/.asciiowl.txt
    neofetch
    export SXHKD_FIFO=/tmp/sxhkd-fifo
fi

if [[ -z $XDG_CURRENT_DESKTOP ]]; # Check if currentl using a XDG-compatible desktop environment

then # If not, assume using a window manager and manually remap keys via xmodmap
    #xmodmap ~/.xmodmap
    echo "Not a XDG-compatible DE..." >&2
   export XDG_CONFIG_HOME=$HOME/.config
fi

export GPG_TTY=$(tty)



