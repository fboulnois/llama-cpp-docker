#!/bin/sh

set -eu

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
