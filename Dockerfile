FROM ubuntu:latest

COPY . /opt/easypeasyespanol.github.io

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN \
  apt-get update \
    && \
  apt-get install -y -qq --no-install-recommends \
    ttf-mscorefonts-installer \
    fontconfig \
    
RUN \
  fc-cache -fv \
    && \
  echo "installed fonts"
