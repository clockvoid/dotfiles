# settings for path
export JAVA_HOME=`/usr/libexec/java_home`
export ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export FLUTTER_HOME=$HOME/git/flutter/flutter
export FIND_UTILS=$(brew --prefix)/opt/findutils/libexec/gnubin
export CORE_UTILS=$(brew --prefix)/opt/coreutils/libexec/gnubin

export PATH=$FIND_UTILS:$CORE_UTILS:$GOROOT/bin:$JAVA_HOME/bin:$ANDROID_SDK_HOME/platform-tools:$FLUTTER_HOME/bin:$PATH
