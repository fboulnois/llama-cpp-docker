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
make llama-3-8b
make up
```

After starting up the chat server will be available at `http://localhost:8080`.

## Options

Options are specified as environment variables in the `docker-compose.yml` file.
By default, the following options are set:

* `GGML_CUDA_NO_PINNED`: Disable pinned memory for compatability (default is 1)
* `LLAMA_ARG_CTX_SIZE`: The context size to use (default is 2048)
* `LLAMA_ARG_MODEL`: The name of the model to use (default is `/models/Meta-Llama-3.1-8B-Instruct-Q5_K_M.gguf`)
* `LLAMA_ARG_N_GPU_LAYERS`: The number of layers to run on the GPU (default is 99)

See the [llama.cpp documentation](https://github.com/ggerganov/llama.cpp/tree/master/examples/server)
for the complete list of server options.

## Models

The [`docker-entrypoint.sh`](docker-entrypoint.sh) has targets for downloading
popular models. Run `./docker-entrypoint.sh --help` to list available models.
Download models by running `./docker-entrypoint.sh <model>` where `<model>` is
the name of the model. By default, these will download the `_Q5_K_M.gguf`
versions of the models. These models are quantized to 5 bits which provide a
good balance between speed and accuracy.

Confused about which model to use? Below is a list of popular models, ranked by
[ELO rating](https://en.wikipedia.org/wiki/Elo_rating_system). Generally, the
higher the ELO rating the better the model.

| Target | Model | Parameters | Size | [~Score](https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard) | [~ELO](https://chat.lmsys.org/?leaderboard) | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| gemma-2-9b | [`gemma-2-9b-it`](https://huggingface.co/bartowski/gemma-2-9b-it-GGUF) | 9B | 6.65 GB | 28.90 | 1187 | Google's best small model |
| ministral-8b | [`ministral-8b-instruct-2410`](https://huggingface.co/bartowski/Ministral-8B-Instruct-2410-GGUF) | 8B | 5.72 GB | 22.01 | 1182 | Mistral AI's best small model |
| llama-3-8b | [`meta-llama-3.1-8b-instruct`](https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF) | 8B | 5.73 GB | 26.59 | 1162 | The overall best small model |
| phi-3.5-mini | [`phi-3.5-mini-instruct`](https://huggingface.co/bartowski/Phi-3.5-mini-instruct-GGUF) | 3B | 3.14 GB | 27.57 | 1071 | Microsoft's best tiny model |
