FROM ubuntu:22.04

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    zip \
    unzip \
    curl \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash \
 && apt-get install -y --no-install-recommends \
    nodejs \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN npm config set cache /tmp/npm_cache --global

RUN cd /tmp \
  && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip -q awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip

RUN mkdir -p /www

WORKDIR /www
