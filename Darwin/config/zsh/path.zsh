# settings for path
[ -f "/opt/homebrew/bin/brew" ] && eval $(/opt/homebrew/bin/brew shellenv)

export JAVA_HOME=`/usr/libexec/java_home`
export _ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export FLUTTER_HOME=$HOME/git/flutter/flutter
export FIND_UTILS=$(brew --prefix)/opt/findutils/libexec/gnubin
export CORE_UTILS=$(brew --prefix)/opt/coreutils/libexec/gnubin
export GOPATH=$(go env GOPATH)

export PATH=$FIND_UTILS:$CORE_UTILS:$GOROOT/bin:$JAVA_HOME/bin:$_ANDROID_SDK_HOME/platform-tools:$FLUTTER_HOME/bin:$GOPATH/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi
