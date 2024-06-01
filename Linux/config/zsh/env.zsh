# settings for path
export CUDA_ROOT=/usr/local/cuda
export LLVM_ROOT=/usr/lib/llvm-7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:CUDA_ROOT/lib64
export CHROME_EXECUTABLE=chromium
command -v go >/dev/null && export GOPATH=$(go env GOPATH)
export ANDROID_CMD_TOOLS=$HOME/Android/Sdk/cmdline-tools/latest/bin
export ANDROID_PLATFORM_TOOLS=$HOME/Android/Sdk/platform-tools
export FLUTTER_HOME=$HOME/.local/opt/flutter

export PATH=$LLVM_ROOT/bin:$CUDA_ROOT/bin:$HOME/.gem/ruby/2.4.0/bin:$ANDROID_PLATFORM_TOOLS:$ANDROID_CMD_TOOLS:$FLUTTER_HOME/bin:$GOPATH/bin:$PATH
