#source: https://lalejini.com/2021/01/09/bookdown-autodeploy.html

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

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN \
  apt-get update \
    && \
  apt-get install -y -qq --no-install-recommends \
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

########################################################
# install r with whatever r packages we need/want
# - source: https://rtask.thinkr.fr/installation-of-r-4-0-on-ubuntu-20-04-lts-and-tips-for-spatial-packages/
########################################################
RUN \
  apt-get install -y -q --no-install-recommends \
    r-base \
    r-base-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libmagick++-dev \
    libxml2-dev \
    libfontconfig1-dev \
    cargo \
    && \
  R -e "install.packages('rmarkdown', dependencies=NA, repos='http://cran.rstudio.com/')" \
    && \
  R -e "install.packages('knitr', dependencies=NA, repos='http://cran.rstudio.com/')" \
    && \
  R -e "install.packages('bookdown', dependencies=NA, repos='http://cran.rstudio.com/')" \
    && \
  R -e "install.packages('tidyverse',dependencies=NA, repos='http://cran.rstudio.com/')" \
    && \
  R -e "install.packages('cowplot',dependencies=NA, repos='http://cran.rstudio.com/')" \
    && \
  echo "installed r and configured r environment"

########################################################
# build book
########################################################
RUN \
  cd /opt/easypeasyespanol.github.io \
    && \
  Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')" \
    && \
  Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')" \
    && \
  echo "compiled bookdown ebook"
