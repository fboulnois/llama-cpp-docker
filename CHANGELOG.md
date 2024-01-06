# Changelog

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
