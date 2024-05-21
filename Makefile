USE_SUDO := $(shell which docker >/dev/null && docker ps 2>&1 | grep -q "permission denied" && echo sudo)
DOCKER := $(if $(USE_SUDO), sudo docker, docker)
DIRNAME := $(notdir $(CURDIR))
HAS_NVIDIA_GPU := $(shell which nvidia-smi >/dev/null && nvidia-smi --query --display=COMPUTE && echo ok)

build:
ifdef HAS_NVIDIA_GPU
	$(DOCKER) build . --tag $(DIRNAME)
else
	$(DOCKER) build . --file Dockerfile-cpu --tag $(DIRNAME)
endif

llama-2-13b:
	cd models && ../docker-entrypoint.sh $@

mistral-7b:
	cd models && ../docker-entrypoint.sh $@

solar-10b:
	cd models && ../docker-entrypoint.sh $@

starling-7b:
	cd models && ../docker-entrypoint.sh $@

command-r:
	cd models && ../docker-entrypoint.sh $@

llama-3-8b:
	cd models && ../docker-entrypoint.sh $@

phi-3-mini:
	cd models && ../docker-entrypoint.sh $@

up:
ifdef HAS_NVIDIA_GPU
	$(DOCKER) compose -f docker-compose.yml -f docker-compose.gpu.yml up
else
	$(DOCKER) compose -f docker-compose.yml up
endif

down:
	$(DOCKER) compose down
