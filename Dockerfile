# Usa una base leggera con GUI supportata
FROM ubuntu:24.04

RUN userdel -r ubuntu

ARG CONTAINER_USERNAME=utente
ENV CONTAINER_USERNAME=${CONTAINER_USERNAME}

ENV workspace=/tmp
COPY . ${workspace}

WORKDIR ${workspace}
RUN chmod +x ${workspace}/installer.sh
RUN ${workspace}/installer.sh

#RUN getent group kvm || groupadd -r kvm

# Crea un utente non root
ARG PUID=1000
ARG PGID=1000
RUN groupadd -g $PGID ${CONTAINER_USERNAME} && \
    useradd -m -u $PUID -g $PGID -G kvm -s /bin/bash ${CONTAINER_USERNAME}

RUN mkdir -p /home/${CONTAINER_USERNAME}/.config/Google/AndroidStudio2024.2 && chown -R ${CONTAINER_USERNAME}:${CONTAINER_USERNAME} /home/${CONTAINER_USERNAME}/.config

# Cambia contesto all'utente non root
USER ${CONTAINER_USERNAME}
WORKDIR /home/${CONTAINER_USERNAME}

# Imposta PATH
ENV PATH="/opt/android-studio/bin:$PATH"

# Comando di avvio
CMD ["studio"]
