FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /vpn
WORKDIR /vpn

COPY ./start.sh ./
RUN chmod +x ./start.sh

RUN apt-get update && \
    apt-get install -y \
    dialog apt-utils

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN add-apt-repository ppa:wireguard/wireguard && \
    apt-get update && \
    apt-get install -y wireguard

RUN curl https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb \
    --output nordvpn-release_1.0.0_all.deb && \
    dpkg -i ./nordvpn-release_1.0.0_all.deb && \
    apt-get update && \
    apt-get install -y nordvpn || true

ENTRYPOINT [ "./start.sh" ]
