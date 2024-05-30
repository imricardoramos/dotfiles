### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
autoload -Uz compinit
compinit

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
base16_monokai

### Plugins
zinit light willghatch/zsh-saneopt
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
### /Plugins

# Starship prompt
eval "$(starship init zsh)"

# ASDF
. "$HOME/.asdf/asdf.sh"
export PATH="$HOME/.asdf/installs/python/3.11.5/bin/:$PATH"

# Colored Man Pages
export LESS_TERMCAP_md=$(tput bold; tput setaf 2)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_mb=$(tput bold; tput setaf 3)
export LESS_TERMCAP_us=$(tput bold; tput setaf 3)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_so=$(tput bold)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)

# Turn off all beeps
unsetopt BEEP
setopt auto_pushd

#Fix keys not working
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# Use LunarVim as default editor
export EDITOR=lvim
export PATH=$HOME/.local/bin:$PATH

# Misc
export HIGHLIGHT_STYLE=molokai

# Doom Emacs
export PATH="$HOME/.config/emacs/bin:$PATH"

# Presserve iex history
export ERL_AFLAGS="-kernel shell_history enabled"

# PERSONAL STUFF
# fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Use GPG Agent instead of SSH Agent for SSH Authentication
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Java
. ~/.asdf/plugins/java/set-java-home.zsh

# Use direnv
eval "$(direnv hook zsh)"

# END PERSONAL STUFF

# Aliases
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias gitu='git add . && git commit && git push'
alias vlc='vlc -I dummy'
alias ls='eza'
alias ll='ls -al --color=always'
alias dc='docker-compose'
alias vim='lvim'
alias vimdiff='lvim -d'
alias ag='ag --ignore-dir node_modules --ignore-dir .git --ignore-dir _build'
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Completions
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
