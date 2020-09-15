ARG base
FROM $base

# GCC

RUN apt-get install -y --no-install-recommends mingw-w64
