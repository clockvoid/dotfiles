# jump to git repository root directory
# from https://bezhermoso.github.io/2018/07/28/jump-back-up-to-git-repo-root-directory/

jump-to-git-root() {
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

alias gr=jump-to-git-root
