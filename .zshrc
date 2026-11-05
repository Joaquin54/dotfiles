# Enable Powerlevel10k instant prompt
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] \
  && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#
# ~/.zshrc
# export PATH="$(brew --prefix python@3.12)/libexec/bin:$PATH"
#
# ---- Zinit ------------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ -f $ZINIT_HOME/zinit.zsh ]]; then
  source "$ZINIT_HOME/zinit.zsh"
fi
# If not running interactively, don't do anything
[[ -o interactive ]] || return
# ---- Prompt (Powerlevel10k) --------------------------------------------------
# Load Powerlevel10k theme (must be before plugins that modify prompt)
zinit ice depth=1
zinit light romkatv/powerlevel10k
# ---- Zsh plugins ------------------------------------------------------------
# Fast syntax highlighting (must be last)
zinit light zdharma-continuum/fast-syntax-highlighting
# Autosuggestions
zinit light zsh-users/zsh-autosuggestions
# Better completions
zinit light zsh-users/zsh-completions
# ---- Basics -----------------------------------------------------------------
# Environment variables
# Prompt (bash-style equivalent)
PROMPT='[%n@%m %1~]%# '
# Aliases
alias ls='gls -lh --color=auto --group-directories-first'
alias grep='grep --color=auto'
# Use neovim when available
if command -v nvim >/dev/null 2>&1; then
  alias vim='nvim'
fi
# Rust (cargo) env
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
# npm user bin path
export PATH="$HOME/.npm-global/bin:$PATH"
# ---- fzf integration (zsh) --------------------------------------------------
# Official fzf key bindings & completion for zsh
if command -v brew >/dev/null; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi
# Custom Ctrl-F file/dir picker (zle widget)
fzf_file_widget_ctrlf() {
  local selected
  selected=$(find \
    "$HOME/.config" \
    "$HOME/Documents" \
    "$HOME/Downloads" \
    "$HOME/Projects" \
    "$HOME/scripts" \
    "$HOME/.zshrc" \
    \( -type f -o -type d \) 2>/dev/null \
    | fzf --height 40% --reverse --prompt="  ")
  if [[ -n "$selected" ]]; then
    if [[ -d "$selected" ]]; then
      BUFFER="cd ${(q)selected}"
      zle accept-line
    else
      BUFFER="${BUFFER[1,$CURSOR]}${selected}${BUFFER[$CURSOR+1,-1]}"
      CURSOR=$(( CURSOR + ${#selected} ))
      zle reset-prompt
    fi
  else
    zle reset-prompt
  fi
}
zle -N fzf_file_widget_ctrlf
bindkey '^F' fzf_file_widget_ctrlf
# ---- End --------------------------------------------------------------------
# To customize prompt, run p10k configure or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
