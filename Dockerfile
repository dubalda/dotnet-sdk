FROM mcr.microsoft.com/dotnet/core/sdk:2.2

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
      xz-utils \
      unzip \
      default-jre \
      nodejs && \
    apt-get clean && \
    dotnet tool install --global dotnet-sonarscanner && \
    wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.5.0.2216-linux.zip && \
    unzip -q sonar-scanner-cli-*.zip && \
    rm sonar-scanner-cli-*.zip && \
    mv sonar-scanner-*-linux /opt/sonar-scanner && \
    dotnet --info && \
    java -version && \
    node --version &&\
    npm --version && \
    sonar-scanner -v
