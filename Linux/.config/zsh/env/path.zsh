# settings for path
export ANYENV_ROOT=$HOME/.anyenv
export CUDA_ROOT=/usr/local/cuda
export LLVM_ROOT=/usr/lib/llvm-7
export PATH=$LLVM_ROOT/bin:$CUDA_ROOT/bin:$ANYENV_ROOT/bin:$PATH:$HOME/.gem/ruby/2.4.0/bin:$HOME/.local/bin:$HOME/.cargo/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:CUDA_ROOT/lib64

eval "$(anyenv init -)"
