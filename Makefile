DOCKER := $(if $(shell docker ps >/dev/null 2>&1 && echo ok), docker, sudo docker)
DIRNAME := $(notdir $(CURDIR))

build:
	$(DOCKER) build . --tag $(DIRNAME)

build-cpu:
	$(DOCKER) build . --file Dockerfile-cpu --tag $(DIRNAME)

llama-13b:
	cd models \
		&& curl -LO https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q5_K_M.gguf \
		&& echo "ef36e090240040f97325758c1ad8e23f3801466a8eece3a9eac2d22d942f548a  llama-2-13b-chat.Q5_K_M.gguf" | sha256sum -c -

mistral-7b:
	cd models \
		&& curl -LO https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.gguf \
		&& echo "b85cdd596ddd76f3194047b9108a73c74d77ba04bef49255a50fc0cfbda83d32  mistral-7b-instruct-v0.2.Q5_K_M.gguf" | sha256sum -c -

solar-10b:
	cd models \
		&& curl -LO https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF/resolve/main/solar-10.7b-instruct-v1.0.Q5_K_M.gguf \
		&& echo "4ade240f5dcc253272158f3659a56f5b1da8405510707476d23a7df943aa35f7  solar-10.7b-instruct-v1.0.Q5_K_M.gguf" | sha256sum -c -

up:
	$(DOCKER) compose up

down:
	$(DOCKER) compose down
