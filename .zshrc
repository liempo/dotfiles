# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# oh-my-zsh themes
ZSH_THEME="agnoster"

# oh-my-zsh plugins
plugins=(git ssh-agent)

# Automatically load ssh keys and configure custom git ssh command
zstyle :omz:plugins:ssh-agent identities id_ed25519_personal id_ed25519_work

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

# Activate virtualenv if .venv exists on cd
function cd() {
  builtin cd "$@"
  if [[ -z "$VIRTUAL_ENV" ]] ; then
      if [[ -d ./.venv ]] ; then
        source ./.venv/bin/activate
      fi
  else
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}

#  tmux attach or create session
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')
  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Activate zoxide
eval "$(zoxide init zsh)"

#  Custom aliases
alias swift-format-all="find . -name '*.swift' -exec swift-format -i {} \;"
