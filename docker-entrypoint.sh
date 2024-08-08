#!/bin/sh

set -eu

# download model if specified as argument and exit
if [ "$#" -eq 1 ]; then
    if [ "$1" = "llama-2-13b" ]; then
        MODEL_URL="https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q5_K_M.gguf"
        MODEL_SHA256="ef36e090240040f97325758c1ad8e23f3801466a8eece3a9eac2d22d942f548a"
    elif [ "$1" = "mistral-7b" ]; then
        MODEL_URL="https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.gguf"
        MODEL_SHA256="b85cdd596ddd76f3194047b9108a73c74d77ba04bef49255a50fc0cfbda83d32"
    elif [ "$1" = "solar-10b" ]; then
        MODEL_URL="https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF/resolve/main/solar-10.7b-instruct-v1.0.Q5_K_M.gguf"
        MODEL_SHA256="4ade240f5dcc253272158f3659a56f5b1da8405510707476d23a7df943aa35f7"
    elif [ "$1" = "starling-7b" ]; then
        MODEL_URL="https://huggingface.co/bartowski/Starling-LM-7B-beta-GGUF/resolve/main/Starling-LM-7B-beta-Q5_K_M.gguf"
        MODEL_SHA256="c67b033bff47e7b8574491c6c296c094e819488d146aca1c6326c10257450b99"
    elif [ "$1" = "command-r" ]; then
        MODEL_URL="https://huggingface.co/bartowski/c4ai-command-r-v01-GGUF/resolve/main/c4ai-command-r-v01-Q5_K_M.gguf"
        MODEL_SHA256="1a59aeb034b64e430d25bc9f2b29d9f2cc658af38670fae36226585603da8ecc"
    elif [ "$1" = "llama-3-8b" ]; then
        MODEL_URL="https://huggingface.co/bartowski/Meta-Llama-3-8B-Instruct-GGUF/resolve/main/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf"
        MODEL_SHA256="16d824ee771e0e33b762bb3dc3232b972ac8dce4d2d449128fca5081962a1a9e"
    elif [ "$1" = "llama-3.1-8b" ]; then
        MODEL_URL="https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF/resolve/main/Meta-Llama-3.1-8B-Instruct-Q5_K_M.gguf"
        MODEL_SHA256="14e10feba0c82a55da198dcd69d137206ad22d116a809926d27fa5f2398c69c7"
    elif [ "$1" = "phi-3-mini" ]; then
        MODEL_URL="https://huggingface.co/bartowski/Phi-3-mini-4k-instruct-GGUF/resolve/main/Phi-3-mini-4k-instruct-Q6_K.gguf"
        MODEL_SHA256="597a483b0e56360cb488d3f8a5ec0fd2c3a3eb44da7bb69020b79ba7c1f6ce85"
    elif [ "$1" = "phi-3-medium" ]; then
        MODEL_URL="https://huggingface.co/bartowski/Phi-3-medium-4k-instruct-GGUF/resolve/main/Phi-3-medium-4k-instruct-Q5_K_M.gguf"
        MODEL_SHA256="5e9d850d6c899e7fdf39a19cdf6fecae225e0c5bb3d13d6f277cbda508a15f0c"
    elif [ "$1" = "gemma-2-9b" ]; then
        MODEL_URL="https://huggingface.co/bartowski/gemma-2-9b-it-GGUF/resolve/main/gemma-2-9b-it-Q5_K_M.gguf"
        MODEL_SHA256="a4b0b55ce809a09baaefb789b0046ac77ecd502aba8aeb2ed63cc237d9f40ce7"
    elif [ "$1" = "gemma-2-27b" ]; then
        MODEL_URL="https://huggingface.co/bartowski/gemma-2-27b-it-GGUF/resolve/main/gemma-2-27b-it-Q5_K_M.gguf"
        MODEL_SHA256="fbefa7ddf24b32dee231c40e0bdd55f9a3ef0e64c8559b0cb48b66cce66fe671"
    else
        echo "$0 [llama-2-13b|mistral-7b|solar-10b|starling-7b|command-r|llama-3-8b|llama-3.1-8b|phi-3-mini|phi-3-medium|gemma-2-9b|gemma-2-27b]"
        exit 1
    fi
    MODEL_NAME=$(basename "$MODEL_URL")
    curl -LO "$MODEL_URL"
    echo "$MODEL_SHA256  $MODEL_NAME" | sha256sum -c -
    exit 0
fi

# set default environment variables if not set
if [ -z ${LLAMA_HOST+x} ]; then
    export LLAMA_HOST="0.0.0.0"
fi
if [ -z ${LLAMA_MODEL+x} ]; then
    export LLAMA_MODEL="/models/llama-2-13b-chat.Q5_K_M.gguf"
fi

# convert LLAMA_ environment variables to llama-server arguments
LLAMA_ARGS=$(env | grep LLAMA_ | awk '{
    # for each environment variable
    for (n = 1; n <= NF; n++) {
        # replace LLAMA_ prefix with --
        sub("^LLAMA_", "--", $n)
        # find first = and split into argument name and value
        eq = index($n, "=")
        s1 = tolower(substr($n, 1, eq - 1))
        s2 = substr($n, eq + 1)
        # replace _ with - in argument name
        gsub("_", "-", s1)
        # print argument name and value
        print s1 " " s2
    }
}')

set -x
llama-server $LLAMA_ARGS
