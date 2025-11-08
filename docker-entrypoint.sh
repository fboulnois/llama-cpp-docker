#!/bin/sh

set -eu

# model urls
MODEL_LIST=$(cat << EOF
https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF
https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF
https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF
https://huggingface.co/bartowski/Mistral-Small-Instruct-2409-GGUF
https://huggingface.co/bartowski/mistralai_Mistral-Small-3.2-24B-Instruct-2506-GGUF
https://huggingface.co/bartowski/Ministral-8B-Instruct-2410-GGUF
https://huggingface.co/bartowski/Phi-3-mini-4k-instruct-GGUF
https://huggingface.co/bartowski/Phi-3-medium-4k-instruct-GGUF
https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF
https://huggingface.co/bartowski/microsoft_Phi-4-mini-instruct-GGUF
https://huggingface.co/bartowski/gemma-2-9b-it-GGUF
https://huggingface.co/bartowski/gemma-2-27b-it-GGUF
https://huggingface.co/bartowski/google_gemma-3-12b-it-GGUF
https://huggingface.co/bartowski/google_gemma-3-27b-it-GGUF
https://huggingface.co/bartowski/Qwen2.5-7B-Instruct-GGUF
https://huggingface.co/bartowski/Qwen2.5-14B-Instruct-GGUF
https://huggingface.co/bartowski/Qwen2.5-32B-Instruct-GGUF
https://huggingface.co/bartowski/deepseek-ai_DeepSeek-R1-0528-Qwen3-8B-GGUF
https://huggingface.co/bartowski/DeepSeek-R1-Distill-Qwen-14B-GGUF
https://huggingface.co/bartowski/DeepSeek-R1-Distill-Qwen-32B-GGUF
EOF
)

usage() {
  MODEL_NAMES=$(echo "$MODEL_LIST" | sed 's|https://huggingface.co/||' | sort)
  cat << EOF
Set the LLAMA_ARG_HF_REPO environment variable in docker-compose.yml to
automatically download the model from HuggingFace and use it.

Popular models to download and use:

$MODEL_NAMES

EOF
}

parse_args_check_docker() {
  if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then
    usage
    exit 0
  fi
}

set_default_env_vars() {
  if [ -z ${LLAMA_ARG_HOST+x} ]; then
    export LLAMA_ARG_HOST="0.0.0.0"
  fi
}

set_cache_permissions() {
  UID=$(id -u llama)
  chown -R "$UID:$UID" /home/llama/.cache
  chmod 1777 /home/llama/.cache
}

parse_args_check_docker "$@"
set_default_env_vars
set_cache_permissions

set -x
exec gosu "$UID:$UID" llama-server
