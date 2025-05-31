# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

export GOROOT=
export GOPATH=~/go

export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$GOPATH/bin

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
# DISABLE_MAGIC_FUNCTIONS="true"
# COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
plugins=(brew gh git golang iterm2 macos python ssh tmux zoxide)

source $ZSH/oh-my-zsh.sh


export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set fzf colors to catppuccin-mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# Set up zoxide
eval "$(zoxide init zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

#### Set up some aliases to make life easier ####
export PATH="/opt/shell-color-scripts/colorscripts/:$PATH"

# cd is burned into my brain
alias cd="z $1"

# neovim syncing and muscle memory things
alias syncnvim="~/.dotfiles/scripts/syncnvim.sh"
alias n="nvim $1"
alias vi=nvim
alias vim=nvim

# create an alias to open my workspace directory on my nas
alias workspace="open smb://sean@192.168.86.47/workspace"

# i don't like the ~ key
alias reloadz="source ~/.zshrc"

# mounting and unmounting filesystems with sshfs / macFUSE

alias connect="$HOME/.dotfiles/scripts/connect_to_remote_servers.sh"

alias umservers="~/.dotfiles/scripts/umservers.sh"
alias cleandir="~/.dotfiles/scripts/cleandir.sh"
source ~/.dotfiles/.sshfs

alias genai="~/.dotfiles/scripts/genai.sh"

# Image Generation Project Aliases
alias imggen="/Users/sean/Projects/image-gen-v2/venv/bin/streamlit run /Users/sean/Projects/image-gen-v2/app/main_webui.py"
alias imggencli="/Users/sean/Projects/image-gen-v2/venv/bin/python /Users/sean/Projects/image-gen-v2/app/main.py"

# Alias for stable diffusion image generation
alias sdwebui="cd ~/Projects/ai/stable-diffusion-webui && source venv310/bin/activate && python launch.py --enable-insecure-extension-access --skip-torch-cuda-test --no-half --api --listen --port 7860"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export TERM=xterm-256color
