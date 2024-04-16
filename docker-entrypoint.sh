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
    else
        echo "$0 [llama-2-13b|mistral-7b|solar-10b|starling-7b]"
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
