ARG base
FROM $base

# Node.js

RUN wget -O - https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y --no-install-recommends nodejs

# Emscripten

RUN git clone https://github.com/emscripten-core/emsdk.git \
    && cd emsdk \
    && git pull \
    && ./emsdk install latest

# Chromium Browser

# chromium-browser for focal requires snap which is not available in docker container
# ref: https://ahelpme.com/linux/ubuntu/chromium-browser-in-ubuntu-20-04-lts-without-snap-to-use-in-docker-container/
RUN apt-key adv --fetch-keys "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xea6e302dc78cc4b087cfc3570ebea9b02842f111" \
    && echo 'deb http://ppa.launchpad.net/chromium-team/stable/ubuntu bionic main' >> /etc/apt/sources.list.d/chromium-team-stable.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends chromium-browser
