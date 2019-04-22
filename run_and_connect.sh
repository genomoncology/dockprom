#!/bin/bash

ADMIN_USER=admin ADMIN_PASSWORD=admin docker-compose up -d

docker network connect knowledge_default caddy

export CADDY_IP=$(docker inspect knowledge_default > network.txt && grep -A3 "caddy" network.txt | tail -n 1 | cut -d'"' -f 4 | cut -d'/' -f 1) && echo "ssh -L 3000:${CADDY_IP}:3000 -N ${HOSTNAME}.genomoncology.io" && rm -f network.txt
