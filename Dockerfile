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
ENV PUID=${PUID}
ENV PGID=${PGID}

RUN groupadd -g $PGID ${CONTAINER_USERNAME} && \
    useradd -m -u $PUID -g $PGID -G kvm -s /bin/bash ${CONTAINER_USERNAME} && \
    echo "${CONTAINER_USERNAME} ALL=(ALL) NOPASSWD:SETENV: /usr/local/bin/chown-user.sh" > /etc/sudoers.d/${CONTAINER_USERNAME} && \
    chmod 0440 /etc/sudoers.d/${CONTAINER_USERNAME} && \
    visudo -cf /etc/sudoers.d/${CONTAINER_USERNAME}

COPY chown-user.sh /usr/local/bin/chown-user.sh
RUN chmod +x /usr/local/bin/chown-user.sh

# Copia lo script di avvio
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Cambia contesto all'utente non root
USER ${CONTAINER_USERNAME}
WORKDIR /home/${CONTAINER_USERNAME}

RUN mkdir -p /home/${CONTAINER_USERNAME}/.config/Google/AndroidStudio2024.2

# Imposta PATH
ENV PATH="/opt/android-studio/bin:$PATH"

# Usa lo script di avvio come punto di ingresso
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
