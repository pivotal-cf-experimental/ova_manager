#!/bin/bash
set -ex

echo "-----> Running script: $0"

docker run \
  --rm=true \
  --volume=${PWD}:/ova_manager \
  --workdir=/ova_manager \
  ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME} \
  /bin/sh -c 'bundle && bundle exec rspec --format documentation'
