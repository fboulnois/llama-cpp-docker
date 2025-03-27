#!/bin/sh

set -eu

# model target, sha256 hash, and url
MODEL_LIST=$(cat << EOF
llama-2-13b ef36e090240040f97325758c1ad8e23f3801466a8eece3a9eac2d22d942f548a https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q5_K_M.gguf
llama-3-8b 14e10feba0c82a55da198dcd69d137206ad22d116a809926d27fa5f2398c69c7 https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF/resolve/main/Meta-Llama-3.1-8B-Instruct-Q5_K_M.gguf
mistral-7b 0374072546aaf1257d1e34610edb11b691730d8ef7d44b5629693a2dd8e8d472 https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF/resolve/main/Mistral-7B-Instruct-v0.3-Q5_K_M.gguf
mistral-small b84ae96c2b36975beb785f09579b411ea68a83f2eabd37bd17f6b64052e8cb75 https://huggingface.co/bartowski/Mistral-Small-Instruct-2409-GGUF/resolve/main/Mistral-Small-Instruct-2409-Q5_K_M.gguf
ministral-8b 190766d270e0e13a8ea2d1ff5bc2faae8cf5897736881bd1fd1698651cc82c8b https://huggingface.co/bartowski/Ministral-8B-Instruct-2410-GGUF/resolve/main/Ministral-8B-Instruct-2410-Q5_K_M.gguf
solar-10b 4ade240f5dcc253272158f3659a56f5b1da8405510707476d23a7df943aa35f7 https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF/resolve/main/solar-10.7b-instruct-v1.0.Q5_K_M.gguf
starling-7b c67b033bff47e7b8574491c6c296c094e819488d146aca1c6326c10257450b99 https://huggingface.co/bartowski/Starling-LM-7B-beta-GGUF/resolve/main/Starling-LM-7B-beta-Q5_K_M.gguf
command-r da705fbbfceaa128528cb9dd15dc1936adbb11e80d2ef504bf39bf8d0f521e3c https://huggingface.co/bartowski/c4ai-command-r-08-2024-GGUF/resolve/main/c4ai-command-r-08-2024-Q5_K_M.gguf
phi-3-mini 597a483b0e56360cb488d3f8a5ec0fd2c3a3eb44da7bb69020b79ba7c1f6ce85 https://huggingface.co/bartowski/Phi-3-mini-4k-instruct-GGUF/resolve/main/Phi-3-mini-4k-instruct-Q6_K.gguf
phi-3-medium 5e9d850d6c899e7fdf39a19cdf6fecae225e0c5bb3d13d6f277cbda508a15f0c https://huggingface.co/bartowski/Phi-3-medium-4k-instruct-GGUF/resolve/main/Phi-3-medium-4k-instruct-Q5_K_M.gguf
phi-3.5-mini df76b3117fac9fbcce3456b386d0250cbfded9f2e6878207250124d1966e9192 https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF/blob/main/Phi-3.5-mini-instruct-Q6_K.gguf
gemma-2-9b a4b0b55ce809a09baaefb789b0046ac77ecd502aba8aeb2ed63cc237d9f40ce7 https://huggingface.co/bartowski/gemma-2-9b-it-GGUF/resolve/main/gemma-2-9b-it-Q5_K_M.gguf
gemma-2-27b fbefa7ddf24b32dee231c40e0bdd55f9a3ef0e64c8559b0cb48b66cce66fe671 https://huggingface.co/bartowski/gemma-2-27b-it-GGUF/resolve/main/gemma-2-27b-it-Q5_K_M.gguf
qwen2.5-7b 2e998d7e181c8756c5ffc55231b9ee1cdc9d3acec4245d6e27d32bd8e738c474 https://huggingface.co/bartowski/Qwen2.5-7B-Instruct-GGUF/resolve/main/Qwen2.5-7B-Instruct-Q5_K_M.gguf
qwen2.5-14b 48ad2dafedac636f62847f5338c356cd21f5cfa6b1e2c885360cb10c890b8cb2 https://huggingface.co/bartowski/Qwen2.5-14B-Instruct-GGUF/resolve/main/Qwen2.5-14B-Instruct-Q5_K_M.gguf
qwen2.5-32b 371c9d50b4c2db96c7b6695b81a23c03c10a0ee780a8c3fe9193aac148febdaf https://huggingface.co/bartowski/Qwen2.5-32B-Instruct-GGUF/resolve/main/Qwen2.5-32B-Instruct-Q5_K_M.gguf
EOF
)

usage() {
  MODEL_NAMES=$(echo "$MODEL_LIST" | awk '{print "  " $1}' | sort)
  cat << EOF
Usage: $0 [MODEL]...
Run llama-server or download a model and exit

If no MODEL is provided, run llama-server with default settings.

Available models to download:

$MODEL_NAMES

EOF
}

parse_args_download_model() {
  if [ "$#" -ge 1 ]; then
    MODEL_LINE=$(echo "$MODEL_LIST" | grep "$1" || true)

    if [ "$1" = "--help" ] || [ -z "$MODEL_LINE" ]; then
      usage
      exit 1
    fi

    MODEL_SHA256=$(echo "$MODEL_LINE" | awk '{print $2}')
    MODEL_URL=$(echo "$MODEL_LINE" | awk '{print $3}')
    MODEL_NAME=$(basename "$MODEL_URL")

    curl -LO "$MODEL_URL"
    echo "$MODEL_SHA256  $MODEL_NAME" | sha256sum -c -
    exit 0
  fi
}

set_default_env_vars() {
  if [ -z ${LLAMA_ARG_HOST+x} ]; then
    export LLAMA_ARG_HOST="0.0.0.0"
  fi
}

parse_args_download_model "$@"
set_default_env_vars

set -x
llama-server
