FROM ubuntu:latest

ARG UTILS_USER_GID=1000
ARG UTILS_USER_UID=1000
ARG RABBITMQ_VERSION=3.11.9

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    locales \
    bind9-host \
    curl \
    dnsutils \
    httpie \
    iputils-ping \
    jq \
    netcat-openbsd \
    # mongodb-clients \
    mysql-client \
    net-tools \
    postgresql-client \
    redis-tools \
    swaks \
    telnet \
    vim \
    nano \
    wget \
    influxdb-client \
    python-setuptools \
    python-pip \
    openssh-client \
    p7zip-full \
    xz-utils \
    gnupg2 \
    kafkacat \
  && rm -rf /var/lib/apt/lists/*

RUN curl -s -O https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 \
  && mv hey_linux_amd64 /usr/local/bin/hey \
  && chmod +x /usr/local/bin/hey

# Locale setup
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Unprivileged user setup
RUN groupadd --gid ${UTILS_USER_GID} utils \
  && useradd --uid ${UTILS_USER_UID} --gid ${UTILS_USER_GID} \
    --shell /bin/bash --create-home utils
USER utils
WORKDIR /home/utils

