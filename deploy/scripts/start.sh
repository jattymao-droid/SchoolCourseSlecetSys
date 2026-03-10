#!/bin/bash
cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
if [ -f "docker-compose-server.yml" ]; then COMPOSE_FILE="docker-compose-server.yml"; else COMPOSE_FILE="docker-compose.yml"; fi
echo "Starting Docker containers..."
docker-compose -f $COMPOSE_FILE up -d
echo "Services started!"
docker-compose -f $COMPOSE_FILE ps