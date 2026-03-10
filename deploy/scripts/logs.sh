#!/bin/bash
cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
if [ -f "docker-compose-server.yml" ]; then COMPOSE_FILE="docker-compose-server.yml"; else COMPOSE_FILE="docker-compose.yml"; fi
if [ -z "$1" ]; then
    docker-compose -f $COMPOSE_FILE logs -f
else
    docker-compose -f $COMPOSE_FILE logs -f $1
fi