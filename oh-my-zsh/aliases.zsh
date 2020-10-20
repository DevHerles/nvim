export EDITOR="nvim"

alias vi="nvim"
alias vim="nvim"

alias cd=' cd'
alias ..=' cd ..; ls'
alias ...=' cd ..; cd ..; ls'
alias ....=' cd ..; cd ..; cd ..; ls'
alias cd..='..'
alias cd...='...'
alias cd....='....'

alias go='git checkout'
alias gst='git status'

alias cls='clear'

alias glop="git log --graph --pretty=format:'%C(#d79921)%h%Creset -%C(yellow)%d%Creset %C(#83a598)%s%Creset %C(#fe8019)(%cr) %C(#665c54)<%an>%Creset' --abbrev-commit --date=relative"
alias glo="git log --oneline --pretty=format:'%C(#d79921)%h%Creset -%C(yellow)%d%Creset %C(#83a598)%s%Creset %C(#fe8019)(%cr) %C(#665c54)<%an>%Creset' --abbrev-commit --date=relative"
alias gpf="git add . & git commit --amend --no-edit & git push -f"
alias gca="git add . & git commit --amend --no-edit"
alias gdf="git diff"

alias dcu="docker-compose up"
alias dcs="docker-compose stop"
alias dcr="docker-compose restart"
alias dcd="docker-compose run --service-ports web"

alias j=jump

alias vs="vim ~/.config/sxhkd/sxhkdrc"
alias vb="vim ~/.config/bspwm/bspwmrc"
alias vp="vim ~/.config/polybar/config"
alias logout="kill -9 -1"
