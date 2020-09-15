ARG base
FROM $base

# GCC

RUN apt-get install -y --no-install-recommends gcc-10 g++-10
ENV CC=gcc-10 CXX=g++-10
