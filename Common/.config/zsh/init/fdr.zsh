# fd - cd to selected directory

fdr() {
  local dir prevcmd
  if ! type tree > /dev/null; then
      prevcmd='echo "To see perfect preview, install tree" && ls {}'
  else
      prevcmd='tree -C {} | head -200'
  fi
  dir=$(fd --hidden --follow --exclude ".git" --exclude "Library" --max-depth 5 | fzf +m --reverse --preview "$prevcmd") &&
  cd "$dir"
}
