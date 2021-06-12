# settings for path
export ANYENV_ROOT=$HOME/.anyenv
export JAVA_HOME=`/usr/libexec/java_home`
export ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$JAVA_HOME/bin:$ANDROID_SDK_HOME/platform-tools:$ANYENV_ROOT/bin:$PATH:$HOME/.local/bin:$HOME/.cargo/bin

eval "$(anyenv init -)"

export PATH=$GOROOT/bin:$PATH
