# Check for ~/.zshrc symlink, create it if none exists
if [[ ! -L ~/.zshrc ]]; then
	ZDOTDIR=~/.config/.zsh
	ln -s "$ZDOTDIR/.zshrc" ~/.zshrc
	source ~/.zshrc
fi

# Check for Starship, install if not present
if ! command -v starship &> /dev/null; then
	echo "Starship not found, installing..."
	yay -S starship --noconfirm

	if [ $? -eq 0 ]; then
		echo "Starship installed successfully"
	else
		echo "Error installing Starship" >&2
		exit 1
	fi
fi

export ZDOTDIR=$HOME/.config/.zsh
export HISTFILE=$ZDOTDIR/.zsh_history
export HISTFILESIZE=1000000
setopt HIST_IGNORE_ALL_DUPS
export ZSH_PLUGINS=/usr/share/zsh/plugins

bindkey ";3D" backward-word
bindkey ";3C" forward-word

alias ls='exa -la'

source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

eval "$(starship init zsh)"
