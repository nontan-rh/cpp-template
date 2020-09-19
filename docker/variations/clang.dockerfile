ARG base
FROM $base

# LLVM & Clang

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends clang-11 clang-tidy-11 clang-format-11
ENV CC=clang-11 CXX=clang++-11
