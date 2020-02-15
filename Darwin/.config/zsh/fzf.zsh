# for fzf searching hidden files
export FZF_DEFAULT_COMMAND="find . -path ./dist -prune -o -path ./.git -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"

