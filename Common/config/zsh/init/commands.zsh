# git branch finder
select-git-branch() {
  target_br=$(
    git branch -a | fzf --exit-0 --height=~100% --reverse --no-multi --preview-window="right,65%" --preview="echo {} | tr -d ' *' | xargs git log --color=always" |
    head -n 1 |
    perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    LBUFFER="${LBUFFER}$target_br"
    local ret=$?
    zle reset-prompt
    return $ret
  else
    zle redisplay
  fi
}
zle -N select-git-branch
bindkey "^b" select-git-branch

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --no-preview --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# jump to root directory of git repository
# from https://bezhermoso.github.io/2018/07/28/jump-back-up-to-git-repo-root-directory/
gr() {
    local _root_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
    if [[ $? -gt 0 ]]; then
        >&2 echo 'Not a Git repo!'
        exit 1
    fi

    local _pwd=$(pwd)
    if [[ $_pwd=$_root_dir ]]; then
        _root_dir="$(git -C $(dirname $_pwd) rev-parse --show-toplevel 2>/dev/null)"
        if [[ $? -gt 0 ]]; then
            echo "Already at Git repo root."
            return 0
        fi
    fi

    OLDPWD=$_pwd
    echo "Git repo root: $_root_dir"
    cd $_root_dir
}
