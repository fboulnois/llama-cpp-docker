#!/bin/sh

set -eu

# model target, sha256 hash, and url
MODEL_LIST=$(cat << EOF
llama-2-13b ef36e090240040f97325758c1ad8e23f3801466a8eece3a9eac2d22d942f548a https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q5_K_M.gguf
mistral-7b b85cdd596ddd76f3194047b9108a73c74d77ba04bef49255a50fc0cfbda83d32 https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.gguf
solar-10b 4ade240f5dcc253272158f3659a56f5b1da8405510707476d23a7df943aa35f7 https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF/resolve/main/solar-10.7b-instruct-v1.0.Q5_K_M.gguf
starling-7b c67b033bff47e7b8574491c6c296c094e819488d146aca1c6326c10257450b99 https://huggingface.co/bartowski/Starling-LM-7B-beta-GGUF/resolve/main/Starling-LM-7B-beta-Q5_K_M.gguf
command-r 1a59aeb034b64e430d25bc9f2b29d9f2cc658af38670fae36226585603da8ecc https://huggingface.co/bartowski/c4ai-command-r-v01-GGUF/resolve/main/c4ai-command-r-v01-Q5_K_M.gguf
llama-3-8b 16d824ee771e0e33b762bb3dc3232b972ac8dce4d2d449128fca5081962a1a9e https://huggingface.co/bartowski/Meta-Llama-3-8B-Instruct-GGUF/resolve/main/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf
llama-3.1-8b 14e10feba0c82a55da198dcd69d137206ad22d116a809926d27fa5f2398c69c7 https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF/resolve/main/Meta-Llama-3.1-8B-Instruct-Q5_K_M.gguf
phi-3-mini 597a483b0e56360cb488d3f8a5ec0fd2c3a3eb44da7bb69020b79ba7c1f6ce85 https://huggingface.co/bartowski/Phi-3-mini-4k-instruct-GGUF/resolve/main/Phi-3-mini-4k-instruct-Q6_K.gguf
phi-3-medium 5e9d850d6c899e7fdf39a19cdf6fecae225e0c5bb3d13d6f277cbda508a15f0c https://huggingface.co/bartowski/Phi-3-medium-4k-instruct-GGUF/resolve/main/Phi-3-medium-4k-instruct-Q5_K_M.gguf
gemma-2-9b a4b0b55ce809a09baaefb789b0046ac77ecd502aba8aeb2ed63cc237d9f40ce7 https://huggingface.co/bartowski/gemma-2-9b-it-GGUF/resolve/main/gemma-2-9b-it-Q5_K_M.gguf
gemma-2-27b fbefa7ddf24b32dee231c40e0bdd55f9a3ef0e64c8559b0cb48b66cce66fe671 https://huggingface.co/bartowski/gemma-2-27b-it-GGUF/resolve/main/gemma-2-27b-it-Q5_K_M.gguf
EOF
)

# download model if specified as argument and exit
if [ "$#" -eq 1 ]; then
    MODEL_LINE=$(echo "$MODEL_LIST" | grep "$1" || true)

    if [ -z "$MODEL_LINE" ]; then
        echo "$MODEL_LIST" | awk '{print $1}' | tr '\n' '|' | sed 's/|$//' | xargs printf "$0 [%s]\n"
        exit 1
    fi

    MODEL_SHA256=$(echo "$MODEL_LINE" | awk '{print $2}')
    MODEL_URL=$(echo "$MODEL_LINE" | awk '{print $3}')
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
