FROM mcr.microsoft.com/dotnet/sdk:3.1.405-buster

ENV NODE_VERSION 14.15.1

ENV PATH="$PATH:/opt/sonar-scanner/bin:/root/.dotnet/tools"
ARG DEBIAN_FRONTEND=noninteractive

RUN set -ex && \
    groupadd --gid 1000 node && \
    useradd --uid 1000 --gid node --shell /bin/bash --create-home node && \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y --quiet --no-install-recommends install \
      apt-utils \
      curl \
      software-properties-common \
      wget \
      tree \
      default-jre \
      nodejs && \
    apt-get clean && \
    dotnet tool install --global dotnet-sonarscanner && \
    dotnet --info && \
    java -version && \
    node --version &&\
    npm --version
