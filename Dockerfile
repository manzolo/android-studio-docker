# Usa una base leggera con GUI supportata
FROM ubuntu:22.04

ENV workspace=/tmp
COPY . ${workspace}

WORKDIR ${workspace}
RUN apt update && apt install wget -y;chmod +x ${workspace}/installer.sh
RUN ${workspace}/installer.sh

#RUN getent group kvm || groupadd -r kvm

# Crea un utente non root
ARG PUID=1000
ARG PGID=1000
RUN groupadd -g $PGID manzolo && \
    useradd -m -u $PUID -g $PGID -G kvm -s /bin/bash manzolo

RUN mkdir -p /home/manzolo/.config/Google/AndroidStudio2024.2 && chown -R manzolo:manzolo /home/manzolo/.config

# Cambia contesto all'utente non root
USER manzolo
WORKDIR /home/manzolo

# Imposta PATH
ENV PATH="/opt/android-studio/bin:$PATH"

# Comando di avvio
CMD ["studio"]
