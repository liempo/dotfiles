# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# oh-my-zsh themes
ZSH_THEME="agnoster"

# oh-my-zsh plugins
plugins=(git ssh-agent)

# Automatically load ssh keys and configure custom git ssh command
zstyle :omz:plugins:ssh-agent identities id_ed25519_personal id_ed25519_work
export GIT_SSH_COMMAND="bash ~/.scripts/git_ssh_wrapper.sh"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Rebind ctrl hjkl
bindkey '^J' down-line-or-history
bindkey '^K' up-line-or-history
bindkey '^L' forward-char
bindkey '^H' backward-char

# Context: user@hostname (without hostname)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# Activate environment on cd
function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If venv folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        source ./.venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}

# Activate zoxide
eval "$(zoxide init zsh)"

# Dotfiles management
alias dots='git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias vim="nvim"
alias swift-format-all="find . -name '*.swift' -exec swift-format -i {} \;"
