# settings for path
export ANYENV_ROOT=$HOME/.anyenv
export JAVA_HOME=`/usr/libexec/java_home -v "11"`
export ANDROID_SDK_HOME=/Users/clock/Library/Android/sdk
export PATH=$JAVA_HOME/bin:$ANDROID_SDK_HOME/platform-tools:$ANYENV_ROOT/bin:$PATH:$HOME/.gem/ruby/2.4.0/bin:$HOME/.local/bin:$HOME/.cargo/bin

eval "$(anyenv init -)"