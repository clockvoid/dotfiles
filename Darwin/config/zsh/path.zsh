# settings for path
[ -f "/opt/homebrew/bin/brew" ] && eval $(/opt/homebrew/bin/brew shellenv)

export JAVA_HOME=`/usr/libexec/java_home`
export _ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export FLUTTER_HOME=$HOME/git/flutter/flutter
export FIND_UTILS=$(brew --prefix)/opt/findutils/libexec/gnubin
export CORE_UTILS=$(brew --prefix)/opt/coreutils/libexec/gnubin
export GOPATH=$(go env GOPATH)

export PATH=$FIND_UTILS:$CORE_UTILS:$GOROOT/bin:$JAVA_HOME/bin:$_ANDROID_SDK_HOME/platform-tools:$FLUTTER_HOME/bin:$GOPATH/bin:$PATH