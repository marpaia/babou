#PROMPT='%{$fg_bold[blue]%}[%{$fg_bold[green]%}%n%{$fg_bold[blue]%}@%{$fg_bold[red]%}%m%{$fg_bold[blue]%}]%{$fg_bold[green]%}%p %{$fg[cyan]%}%c%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
PROMPT='%{$fg_bold[blue]%}[%{$fg_bold[red]%}%m%{$fg_bold[blue]%}]%{$fg_bold[green]%}%p %{$fg[cyan]%}%c%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

RPROMPT='%{$fg_bold[blue]%}%t %W%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_AHEAD_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
