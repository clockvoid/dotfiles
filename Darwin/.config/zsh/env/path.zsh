# settings for path
export ANYENV_ROOT=$HOME/.anyenv
export JAVA_HOME=`/usr/libexec/java_home`
export ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export LLVM_BIN="/usr/local/opt/llvm/bin"
export PATH=$LLVM_BIN:/usr/local/opt/coreutils/libexec/gnubin:$JAVA_HOME/bin:$ANDROID_SDK_HOME/platform-tools:$ANYENV_ROOT/bin:$PATH:$HOME/.gem/ruby/2.4.0/bin:$HOME/.local/bin:$HOME/.cargo/bin

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

eval "$(anyenv init -)"
