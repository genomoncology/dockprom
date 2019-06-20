#!/bin/bash

if [ $# -gt 0 ] && [ $1 == --dev ]
then
    echo "In Dev Mode"
    ADMIN_USER=admin ADMIN_PASSWORD=admin docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
else
   ADMIN_USER=admin ADMIN_PASSWORD=admin docker-compose up -d
fi

docker network connect knowledge_default caddy
docker network connect knowledge_default prometheus

export CADDY_IP=$(docker inspect knowledge_default > network.txt && grep -A3 "caddy" network.txt | tail -n 1 | cut -d'"' -f 4 | cut -d'/' -f 1) && echo "ssh -L 3000:${CADDY_IP}:3000 -N ${HOSTNAME}.genomoncology.io" && rm -f network.txt
