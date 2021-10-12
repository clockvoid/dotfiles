# settings for path
export CUDA_ROOT=/usr/local/cuda
export LLVM_ROOT=/usr/lib/llvm-7
export PATH=$LLVM_ROOT/bin:$CUDA_ROOT/bin:$HOME/.gem/ruby/2.4.0/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:CUDA_ROOT/lib64
