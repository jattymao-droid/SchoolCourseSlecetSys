#!/bin/bash
cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
if [ -f "docker-compose-server.yml" ]; then COMPOSE_FILE="docker-compose-server.yml"; else COMPOSE_FILE="docker-compose.yml"; fi
echo "Service status:"
docker-compose -f $COMPOSE_FILE ps