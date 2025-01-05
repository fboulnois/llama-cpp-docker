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

The [`docker-entrypoint.sh`](docker-entrypoint.sh) has targets for downloading
popular models. Run `./docker-entrypoint.sh --help` to list available models.
Download models by running `./docker-entrypoint.sh <model>` or `make <model>`
where `<model>` is the name of the model. By default, these will download the
`_Q5_K_M.gguf` versions of the models. These models are quantized to 5 bits
which provide a good balance between speed and accuracy.

Confused about which model to use? Below is a list of popular models, ranked by
[ELO rating](https://en.wikipedia.org/wiki/Elo_rating_system). Generally, the
higher the ELO rating the better the model.

| Target | Model | Parameters | Size | [~Score](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) | [~ELO](https://chat.lmsys.org/?leaderboard) | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| gemma-2-9b | [`gemma-2-9b-it`](https://huggingface.co/bartowski/gemma-2-9b-it-GGUF) | 9B | 6.65 GB | 28.90 | 1187 | Google's best small model |
| llama-3-8b | [`meta-llama-3.1-8b-instruct`](https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF) | 8B | 5.73 GB | 26.59 | 1162 | The overall best small model |
| mistral-7b | [`mistral-7b-instruct-v0.3`](https://huggingface.co/bartowski/Mistral-7B-Instruct-v0.3-GGUF) | 7B | 5.13 GB | 18.44 | 1072 | The most popular 7B model |
| phi-3.5-mini | [`phi-3.5-mini-instruct`](https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF) | 3B | 3.14 GB | 27.57 | 1071 | Microsoft's best tiny model |
