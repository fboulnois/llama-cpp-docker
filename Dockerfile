FROM nvidia/cuda:12.6.3-devel-ubuntu22.04 AS env-build

WORKDIR /srv

# install build tools and clone and compile llama.cpp
RUN apt-get update && apt-get install -y build-essential git libgomp1 cmake

RUN git clone https://github.com/ggerganov/llama.cpp.git \
  && cd llama.cpp \
  && cmake -B build -DGGML_CUDA=on -DBUILD_SHARED_LIBS=off \
  && cmake --build build --config Release -j

FROM debian:12-slim AS env-deploy

# copy openmp and cuda libraries
ENV LD_LIBRARY_PATH=/usr/local/lib
COPY --from=0 /usr/lib/x86_64-linux-gnu/libgomp.so.1 ${LD_LIBRARY_PATH}/libgomp.so.1
COPY --from=0 /usr/local/cuda/lib64/libcublas.so.12 ${LD_LIBRARY_PATH}/libcublas.so.12
COPY --from=0 /usr/local/cuda/lib64/libcublasLt.so.12 ${LD_LIBRARY_PATH}/libcublasLt.so.12
COPY --from=0 /usr/local/cuda/lib64/libcudart.so.12 ${LD_LIBRARY_PATH}/libcudart.so.12

# copy llama.cpp binaries
COPY --from=0 /srv/llama.cpp/build/bin/llama-cli /usr/local/bin/llama-cli
COPY --from=0 /srv/llama.cpp/build/bin/llama-server /usr/local/bin/llama-server

# create llama user and set home directory
RUN useradd --system --create-home llama

USER llama

WORKDIR /home/llama

EXPOSE 8080

# copy and set entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
