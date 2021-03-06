
# Path to your oh-my-zsh installation.
# export ZSH=/home/$USER/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="bira"

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
# plugins=(git sudo colorize extract history postgres)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# source $ZSH/oh-my-zsh.sh

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

# Java
# export JAVA_HOME=/usr/java/jdk1.8.0_60
# export CLASSPATH=".:/usr/local/lib/:/usr/local/lib/antlr-4.0-complete.jar:$CLASSPATH"
# export AWT_TOOLKIT=MToolkit
# export _JAVA_AWT_WM_NONREPARENTING=1

# Antlr4
# alias antlr4='java -jar /usr/local/lib/antlr-4.0-complete.jar'
# alias grun='java org.antlr.v4.runtime.misc.TestRig'

# Path
# export PATH="/home/$USER/.cabal/bin:/usr/java/jdk1.8.0_60/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/$USER/.local/bin:/home/$USER/bin:/home/$USER/bin/arduino:/usr/pgsql-9.4/bin"

# stack executables:
# export PATH=/root/.local/bin:$PATH
# export PATH=/home/hhefesto/.local/bin:$PATH

# # rust
# export PATH="$HOME/.cargo/bin:$PATH"

# ssh-keys
# ssh-add ~/.ssh/id_rsa_github
# ssh-add ~/.ssh/communis-front-key.pem
# ssh-add ~/.ssh/id_rsa_rdataa.pem

# Emacs
# if [ -n "$INSIDE_EMACS" ]; then
#     export ZSH_THEME="rawsyntax"
# else
#     export ZSH_THEME="robbyrussell"
# fi

# NVM (Node)
# export NVM_DIR="/home/$USER/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Dropbox
# if pgrep -x 'dropbox'; then
#     echo "Dropbox already running"
# else
#     echo "Starting Dropbox from zshrc"
#     dropbox start &
# fi

# This is commented because it didn't work. Ranger leaves some sort of server runing even after shuting down (I think)
# Ranger
# if pgrep -x 'ranger'; then
#     echo "Ranger already running"
# else
#     echo "Starting Ranger from zshrc"
#     clear
#     ranger
# fi

# My aliases
# alias ls='lsd'
# alias scrot='scrot ~/Pictures/Screenshots/%b%d::%H_%M_%S.png' # this is done in xmonad.hs

# Nix

# added manualy. copied from ~/.bash_profile & left the original there
# if [ -e /home/hhefesto/.nix-profile/etc/profile.d/nix.sh ]; then . /home/hhefesto/.nix-profile/etc/profile.d/nix.sh; fi

# Clear
# clear
eval "$(direnv hook zsh)"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

alias l='ls -lt --color=tty'
