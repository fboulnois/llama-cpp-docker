# Llama.cpp in Docker

Run [llama.cpp](https://github.com/ggerganov/llama.cpp) in a GPU accelerated Docker container.

## Minimum requirements

By default, the service requires a CUDA capable GPU with at least 8GB+ of VRAM. If you don't have an Nvidia GPU with CUDA then the CPU version will be built and used instead.

## Quickstart

```bash
make build
make llama-3-8b
make up
```

After starting up the chat server will be available at `http://localhost:8080`.

## Options

Options are specified as environment variables in the `docker-compose.yml` file. By default, the following options are set:

* `GGML_CUDA_NO_PINNED`: Disable pinned memory for compatability (default is 1)
* `LLAMA_ARG_CTX_SIZE`: The context size to use (default is 2048)
* `LLAMA_ARG_MODEL`: The name of the model to use (default is `/models/Meta-Llama-3.1-8B-Instruct-Q5_K_M.gguf`)
* `LLAMA_ARG_N_GPU_LAYERS`: The number of layers to run on the GPU (default is 99)

See the [llama.cpp documentation](https://github.com/ggml-org/llama.cpp/tree/master/tools/server) for the complete list of server options.

## Models

The [`docker-entrypoint.sh`](docker-entrypoint.sh) has targets for downloading popular models. Run `./docker-entrypoint.sh --help` to list available models. Download models by running `./docker-entrypoint.sh <model>` where `<model>` is the name of the model. By default, these will download the `_Q5_K_M.gguf` versions of the models. These models are quantized to 5 bits which provide a good balance between speed and accuracy.

Confused about which model to use? Below is a list of popular models, ranked by [ELO rating](https://en.wikipedia.org/wiki/Elo_rating_system). Generally, the higher the ELO rating the better the model.

| Target | Model | Parameters | Size | [~ELO](https://chat.lmsys.org/?leaderboard) | Notes |
| --- | --- | --- | --- | --- | --- |
| deepseek-r1-qwen-14b | [`deepseek-r1-distill-qwen-14b`](https://huggingface.co/bartowski/DeepSeek-R1-Distill-Qwen-14B-GGUF) | 14B | 10.5 GB | 1375 | The best small thinking model |
| gemma-3-27b | [`gemma-3-27b-it`](https://huggingface.co/bartowski/google_gemma-3-27b-it-GGUF) | 27B | 19.27 GB | 1361 | Google's best medium model |
| mistral-small-3 | [`mistral-small-3.2-24b-instruct`](https://huggingface.co/bartowski/mistralai_Mistral-Small-3.2-24B-Instruct-2506-GGUF) | 24B | 16.76 GB | 1273 | Mistral AI's best small model |
| llama-3-8b | [`meta-llama-3.1-8b-instruct`](https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF) | 8B | 5.73 GB | 1193 | Meta's best small model |
| phi-4-mini | [`phi-4-mini-instruct`](https://huggingface.co/bartowski/microsoft_Phi-4-mini-instruct-GGUF) | 4B | 2.85 GB | 1088++ | Microsoft's best tiny model |

> [!NOTE]
> Values with `+` are minimum estimates from previous versions of the model due to missing data.
