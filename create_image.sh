#! /bin/bash

REPOSITORY=mrjimenez123/stm32cubeclt
TAG=1.17.0

# build docker
# docker build --progress=plain \
docker build \
        -t "${REPOSITORY}:${TAG}" \
        .

# run with "docker run --rm -it mrjimenez123/stm32cubeclt:1.17.0"
