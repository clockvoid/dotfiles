# fga 

fga() {
    local add files
    add=$(git status -s) &&
    files=$(echo "$add" | fzf +m --no-preview) &&
    git add $(echo "$files" | awk '{print $2}')
}
