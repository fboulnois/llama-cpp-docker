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

The [Makefile](Makefile) has a few targets for downloading popular models. By
default, these will download the `_Q5_K_M.gguf` versions of the models. These
models are quantized to 5 bits which provide a good balance between speed and
accuracy.

| Model | Model Size | (V)RAM Required | [~Score](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) |
| --- | --- | --- | --- |
| [`llama-2-13b-chat`](https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF) | 13B | 11.73 GB | 53.26 |
| [`mistral-7b-instruct-v0.2`](https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF) | 7B | 7.63 GB | 65.71 |
| [`solar-10.7b-instruct-v1.0`](https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF) | 10.7B | 10.10 GB | 74.2 |
