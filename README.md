# cpp-template ![Build](https://github.com/nontan-rh/cpp-template/workflows/Build/badge.svg)

C++ Project Template / Boilerplate for Cross-Platform Development

## Feature

- Built with CMake
  - Shipped with `ExternalProject` dependency building utility
  - Installable as a [cmake-package](https://cmake.org/cmake/help/v3.10/manual/cmake-packages.7.html)
- Cross-platform
  - Linux (GCC / Clang)
  - macOS (Clang)
  - Windows (MSVC / MinGW)
  - Web (Emscripten)
    - with test harness for [Selenium](https://github.com/SeleniumHQ/selenium) and [Chromium](https://www.chromium.org/)
  - Android (no testing yet)
  - iOS (no testing yet)
- CI is fully setup
  - Unit testing with [doctest](https://github.com/onqtam/doctest)
  - Linting with [Clang-Tidy](https://clang.llvm.org/extra/clang-tidy/)
  - Spell checking with [cSpell](https://github.com/streetsidesoftware/cspell)
  - Sanitizers are enabled in some platforms
- "Orthodox" Styling
  - [ClangFormat](https://clang.llvm.org/docs/ClangFormat.html)
  - [editorconfig](https://editorconfig.org/)
- Containerized development environment with docker
  - based on Ubuntu 20.04
- Documentation with [doxygen](https://www.doxygen.nl/index.html)
- Unlicensed
  - this **NEVER** applies to third party softwares included, of course

## Getting started

### Build docker images

#### macOS/Linux

```pwsh
$ pwsh ./script/build_docker_images.ps1 -Prefix cpp-template-
```

#### Windows

```pwsh
> powershell -ExecutionPolicy Unrestricted .\script\build_docker_images.ps1 -Prefix cpp-template-
```

### Enter docker container

```bash
$ docker run -i -v "${PWD}:/cpp-template" -t cpp-template-clang bash
$ cd cpp-template
```

### Build

```bash
$ mkdir -p build && cd build
$ cmake ..
$ cmake --build .
```

### Test

```bash
$ ctest
```

### Format

```bash
$ script/format.sh
```

### Spellcheck

```bash
$ script/cspell.sh
```

### Lint

```bash
$ script/tidy.sh
```
