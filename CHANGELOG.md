# Changelog

## [v1.13.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.12.0...v1.13.0) - 2025-04-21

### Changed

* Split docker images into build and deploy

### Fixed

* Models are predownloaded so disable curl

## [v1.12.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.11.0...v1.12.0) - 2025-03-29

### Added

* Add Phi 4 Mini
* Add Gemma 3 12b and 27b
* Add Mistral Small 3.1 24b
* Add Deepseek R1 Qwen 14b and 32b

### Changed

* Group together similar models

### Fixed

* Remove version from compose files

## [v1.11.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.10.0...v1.11.0) - 2025-01-25

### Added

* Switch to built-in environment variables
* Switch to llama 3.1 8b as default

### Changed

* Only set target for default model

## [v1.10.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.9.0...v1.10.0) - 2025-01-04

### Added

* Update command r to 2024-08
* Sort models alphabetically before output
* Add qwen2.5 7b 14b 32b
* Add mistral small 22b
* Add phi 3.5 mini 3b
* Update mistral 7b to 0.3

### Changed

* Replace mistral 7b with ministral 8b
* Remove old llama 2 model from table

## [v1.9.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.8.0...v1.9.0) - 2024-12-20

### Added

* Update nvidia/cuda to 12.6.3

### Fixed

* Switch to CMake as Makefile is deprecated

## [v1.8.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.7.1...v1.8.0) - 2024-08-17

### Added

* Set llama 3.1 as default llama 3 target
* Add more detailed command line usage
* Add llama 3.1 8b model
* Add phi 3 medium and gemma 2 9b and 27b
* Update nvidia/cuda to 12.5.1

### Changed

* Add pattern rule to download models
* Move shell into functions
* Simplify adding new models

## [v1.7.1](https://github.com/fboulnois/llama-cpp-docker/compare/v1.7.0...v1.7.1) - 2024-06-13

### Fixed

* Copy over new binary names

## [v1.7.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.6.1...v1.7.0) - 2024-06-12

### Added

* Update nvidia/cuda to 12.5.0

### Fixed

* Add libomp to clang build
* Add libgomp to cuda build
* LLAMA_CUBLAS is deprecated

## [v1.6.1](https://github.com/fboulnois/llama-cpp-docker/compare/v1.6.0...v1.6.1) - 2024-05-21

### Fixed

* Include new models as makefile targets (again)

## [v1.6.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.5.1...v1.6.0) - 2024-05-20

### Added

* Add llama 3 8B and phi 3 mini

## [v1.5.1](https://github.com/fboulnois/llama-cpp-docker/compare/v1.5.0...v1.5.1) - 2024-04-15

### Fixed

* Include new models as makefile targets

## [v1.5.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.4.0...v1.5.0) - 2024-04-15

### Added

* Add command-r 35b model
* Add starling 7b beta model
* Sort by lmsys leaderboard elo score
* Update nvidia/cuda to 12.4.1

## [v1.4.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.3.1...v1.4.0) - 2024-03-06

### Fixed

* Use clang 16 instead of gcc in cpu version

## [v1.3.1](https://github.com/fboulnois/llama-cpp-docker/compare/v1.3.0...v1.3.1) - 2024-01-06

### Changed

* Move entrypoint to bottom of Dockerfile

### Fixed

* Suppress missing nvidia-smi command output

## [v1.3.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.2.1...v1.3.0) - 2024-01-03

### Added

* Improve docker sudo detection in Makefile

### Changed

* Move download to docker-entrypoint.sh

### Fixed

* Rename target to llama 2 to match download

## [v1.2.1](https://github.com/fboulnois/llama-cpp-docker/compare/v1.2.0...v1.2.1) - 2023-12-27

### Fixed

* Ensure build stages are named

## [v1.2.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.1.0...v1.2.0) - 2023-12-25

### Added

* Automatically build and run gpu or cpu version

## [v1.1.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.0.0...v1.1.0) - 2023-12-22

### Added

* Convert env vars to command line args

## [v1.0.0](https://github.com/fboulnois/llama-cpp-docker/releases/tag/v1.0.0) - 2023-12-20

### Added

* Do not add downloaded models to git
* Run llama.cpp with GPU enabled Docker Compose
