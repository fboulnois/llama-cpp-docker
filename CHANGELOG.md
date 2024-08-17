# Changelog

## [v1.8.0](https://github.com/fboulnois/llama-cpp-docker/compare/v1.7.1...v1.8.0) - 2024-08-11

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
