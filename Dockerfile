# Pull a base image
FROM ubuntu:20.04

# Copy everything (minus anything specified in .dockerignore) into the image
COPY . /opt/easypeasyespanol.github.io

# To make installs not ask questions about timezones
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN \
  cd /opt/easypeasyespanol.github.io \
  mkdir /_book \
  #cd /_book \
  touch c \
  echo "a" > ~/c
