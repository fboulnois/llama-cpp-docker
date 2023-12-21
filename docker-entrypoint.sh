#!/bin/sh

set -eu

llama-server --host 0.0.0.0 \
    --n-gpu-layers $GPU_LAYERS \
    --model /models/$LLAMA_MODEL \
    --ctx-size $CTX_SIZE
