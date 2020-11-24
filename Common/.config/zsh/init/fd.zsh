# fd - cd to selected directory

fd() {
  local dir prevcmd
  if ! type tree > /dev/null; then
      prevcmd='echo "To see perfect preview, install tree" && ls {}'
  else
      prevcmd='tree {}'
  fi
  dir=$(find ${1:-.} -path '*/\.*' \
          -type d -print 2> /dev/null | fzf +m --reverse --preview "$prevcmd") &&
  cd "$dir"
}
