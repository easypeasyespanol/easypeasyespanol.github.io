#this file obtained from lalejini.com https://lalejini.com/2021/01/09/bookdown-autodeploy.html

# Pull a base image
FROM ubuntu:latest

# Copy everything (minus anything specified in .dockerignore) into the image
COPY . /opt/easypeasyespanol.github.io

# To make installs not ask questions about timezones
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

##############################
# install base dependencies
# - for R repository
#   - dirmngr
#   - gpg-agent
# - for bookdown compilation
#   - pandoc, pandoc-citeproc, texlive-base, texlive-latex-extra
##############################
RUN \
  apt-get update \
    && \
  apt-get install -y -qq --no-install-recommends \
    apt-utils \
    software-properties-common \
    curl \
    g++-10 \
    make\
    cmake \
    python3 \
    python3-pip \
    python3-virtualenv \
    git \
    dirmngr \
    gpg-agent \
    pandoc \
    pandoc-citeproc \
    texlive-base \
    texlive-latex-extra \
    lmodern \
    && \
  echo "installed base dependencies"
