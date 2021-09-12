FROM ubuntu:20.04

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    curl \
    git \
    python3-pip \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg8-dev \
    zlib1g-dev \
    gpg-agent \
    sqlite3 \
    autoconf \
    automake \
    libtool \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh \
 && bash nodesource_setup.sh

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
	zip \
	unzip \
	nodejs \
	graphviz \
	ruby-full \
  	fakeroot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN gem install deb-s3 bundler

RUN pip3 install setuptools --upgrade  --no-cache-dir \
 && pip3 install awscli --upgrade  --no-cache-dir

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN mkdir -p /www

WORKDIR /www
