# Llama.cpp in Docker

Run [llama.cpp](https://github.com/ggerganov/llama.cpp) in a GPU accelerated Docker container.

## Minimum requirements

By default, the service requires a CUDA capable GPU with at least 8GB+ of VRAM. If you don't have an Nvidia GPU with CUDA then the CPU version will be built and used instead.

## Quickstart

```bash
make build
make up
```

After starting up the chat server will be available at `http://localhost:8080`.

## Options

Options are specified as environment variables in the `docker-compose.yml` file. By default, the following options are set:

* `LLAMA_ARG_CTX_SIZE`: The context size to use (default is 2048)
* `LLAMA_ARG_HF_REPO`: The repository and quantization of the HuggingFace model to use (default is `bartowski/Meta-Llama-3.1-8B-Instruct-GGUF:q5_k_m`)
* `LLAMA_ARG_N_GPU_LAYERS`: The number of layers to run on the GPU (default is 99)

See the [llama.cpp documentation](https://github.com/ggml-org/llama.cpp/tree/master/tools/server) for the complete list of server options.

## Models

Use the `LLAMA_ARG_HF_REPO` environment variable to automatically download and use a model from HuggingFace.

The format is `<huggingface-repository><:quant>` where `<:quant>` is optional and specifies the quantization to use. For example, to download a model from `https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF` with no quantization, set the variable to `bartowski/Meta-Llama-3.1-8B-Instruct-GGUF`. To use the same model with `q5_k_m` quantization, set the variable to `bartowski/Meta-Llama-3.1-8B-Instruct-GGUF:q5_k_m`.

Models must be in the GGUF format, which is the default format for `llama.cpp` models. Models quantized with `q5_k_m` are recommended for a good balance between speed and accuracy. To list popular models, run `./docker-entrypoint.sh --help`.

Confused about which model to use? Below is a list of top popular models, ranked by [ELO rating](https://en.wikipedia.org/wiki/Elo_rating_system). Generally, the higher the ELO rating the better the model. Set `LLAMA_ARG_HF_REPO` to the repository name to use a specific model.

| Model | Repository | Parameters | Q5_K_M Size | [~ELO](https://lmarena.ai/leaderboard) | Notes |
| --- | --- | --- | --- | --- | --- |
| gemma-4-31b | [`bartowski/google_gemma-4-31B-it-GGUF`](https://huggingface.co/bartowski/google_gemma-4-31B-it-GGUF) | 31B | 22.61 GB | 1452 | Google's best medium model |
| qwen3.5-27b | [`bartowski/Qwen_Qwen3.5-27B-GGUF`](https://huggingface.co/bartowski/Qwen_Qwen3.5-27B-GGUF) | 27B | 19.95 GB | 1437 | Qwen's best medium model |
| ministral-3-14b-instruct-2512 | [`bartowski/mistralai_Ministral-3-14B-Instruct-2512-GGUF`](https://huggingface.co/bartowski/mistralai_Ministral-3-14B-Instruct-2512-GGUF) | 14B | 9.62 GB | 1410 | Mistral AI's best small model |
| deepseek-r1-distill-qwen-14b | [`bartowski/DeepSeek-R1-Distill-Qwen-14B-GGUF`](https://huggingface.co/bartowski/DeepSeek-R1-Distill-Qwen-14B-GGUF) | 14B | 10.5 GB | 1375 | Deepseek's best small thinking model |
| llama-3.1-8b | [`bartowski/Meta-Llama-3.1-8B-Instruct-GGUF`](https://huggingface.co/bartowski/Meta-Llama-3.1-8B-Instruct-GGUF) | 8B | 5.73 GB | 1211 | Meta's best small model |

> [!NOTE]
> Values with `+` are minimum estimates from previous versions of the model due to missing data.
