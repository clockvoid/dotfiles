# settings for path
export CUDA_ROOT=/usr/local/cuda
export LLVM_ROOT=/usr/lib/llvm-7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:CUDA_ROOT/lib64
export CHROME_EXECUTABLE=chromium
export GOPATH=$(go env GOPATH)

export PATH=$LLVM_ROOT/bin:$CUDA_ROOT/bin:$HOME/.gem/ruby/2.4.0/bin:$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/cmdline-tools/latest/bin:$GOPATH/bin:$PATH
