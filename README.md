# Llama.cpp in Docker

Run [llama.cpp](https://github.com/ggerganov/llama.cpp) in a GPU accelerated
Docker container.

## Minimum requirements

By default, the service requires a CUDA capable GPU with at least 8GB+ of VRAM. 
If you don't have an Nvidia GPU with CUDA then the CPU version will be built and
used instead.

## Quickstart

```bash
make build
make llama-2-13b
make up
```

After starting up the chat server will be available at `http://localhost:8080`.

## Options

Options can be specified as environment variables in the `docker-compose.yml`
file. Environment variables that are prefixed with `LLAMA_` are converted to
command line arguments for the `llama.cpp` server. For example, `LLAMA_CTX_SIZE`
is converted to `--ctx-size`. By default, the following options are set:

* `GGML_CUDA_NO_PINNED`: Disable pinned memory for compatability (default is 1)
* `LLAMA_CTX_SIZE`: The context size to use (default is 2048)
* `LLAMA_MODEL`: The name of the model to use (default is `/models/llama-2-13b-chat.Q5_K_M.gguf`)
* `LLAMA_N_GPU_LAYERS`: The number of layers to run on the GPU (default is 99)

See the [llama.cpp documentation](https://github.com/ggerganov/llama.cpp/tree/master/examples/server)
for the complete list of server options.

## Models

The [Makefile](Makefile) has targets for downloading popular models. By default,
these will download the `_Q5_K_M.gguf` versions of the models. These models are
quantized to 5 bits which provide a good balance between speed and accuracy.

| Target | Model | Model Size | (V)RAM Required | [~Score](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) | [~ELO](https://chat.lmsys.org/?leaderboard) | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| llama-2-13b | [`llama-2-13b-chat`](https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF) | 13B | 11.73 GB | 55.69 | 1067 | The original open LLM |
| solar-10b | [`solar-10.7b-instruct-v1.0`](https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF) | 10.7B | 10.10 GB | 74.20 | 1066 | Scores highly on Huggingface |
| phi-3-mini | [`phi-3-mini`](https://huggingface.co/bartowski/Phi-3-mini-4k-instruct-GGUF) | 3B | 3.13 GB | 69.91 | 1074 | The current best tiny model |
| mistral-7b | [`mistral-7b-instruct-v0.2`](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF) | 7B | 7.63 GB | 65.71 | 1074 | The most popular 7B model |
| starling-7b | [`starling-lm-7b-beta`](https://huggingface.co/bartowski/Starling-LM-7B-beta-GGUF) | 7B | 5.13 GB | 69.88 | 1118 | Scores highly on Huggingface |
| command-r | [`c4ai-command-r-v01`](https://huggingface.co/bartowski/c4ai-command-r-v01-GGUF) | 35B | 25.00 GB | 68.54 | 1149 | The current best medium model |
| llama-3-8b | [`meta-llama-3-8b-instruct`](https://huggingface.co/bartowski/Meta-Llama-3-8B-Instruct-GGUF) | 8B | 5.73 GB | 62.55 | 1154 | The current best small model |
