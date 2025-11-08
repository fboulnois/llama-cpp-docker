USE_SUDO := $(shell which docker >/dev/null && docker ps 2>&1 | grep -q "permission denied" && echo sudo)
DOCKER := $(if $(USE_SUDO), sudo docker, docker)
DIRNAME := $(notdir $(CURDIR))
HAS_NVIDIA_GPU := $(shell which nvidia-smi >/dev/null && nvidia-smi --query --display=COMPUTE && echo ok)

build:
ifdef HAS_NVIDIA_GPU
	$(DOCKER) build --target env-build  . --tag $(DIRNAME)-build
	$(DOCKER) build --target env-deploy . --tag $(DIRNAME)
else
	$(DOCKER) build --target env-build  . --file Dockerfile-cpu --tag $(DIRNAME)-build
	$(DOCKER) build --target env-deploy . --file Dockerfile-cpu --tag $(DIRNAME)
endif

up:
ifdef HAS_NVIDIA_GPU
	$(DOCKER) compose -f docker-compose.yml -f docker-compose.gpu.yml up
else
	$(DOCKER) compose -f docker-compose.yml up
endif

down:
	$(DOCKER) compose down
