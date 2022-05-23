FROM ubuntu:20.04

COPY . /opt/easypeasyespanol.github.io

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

RUN \
  cd /opt/easypeasyespanol.github.io \
  mkdir /_book \
  cd /_book \
  touch b
