#!/bin/bash
# Esegui chown per garantire i permessi corretti

/bin/chown -R ${CONTAINER_USERNAME}:${CONTAINER_USERNAME} /run/user/${PUID}/avd
/bin/chown -R ${CONTAINER_USERNAME}:${CONTAINER_USERNAME} /home/${CONTAINER_USERNAME}/.config