#!/bin/bash

set -e

docker build \
  --tag build \
  --build-arg "munge_version=$( niet munge_version defs.yaml )" \
  --build-arg "slurm_version=$( niet slurm_version defs.yaml )" \
  .

mkdir -p export

docker run -t --rm --workdir=/opt -v $PWD/export:/export:rw build \
  tar cfz /export/munged.tar.gz munge &
docker run -t --rm --workdir=/opt -v $PWD/export:/export:rw build \
  tar cfz /export/slurm.tar.gz slurm &
wait
docker run -t --rm --workdir=/opt -v $PWD/export:/export:rw build \
  chmod -R 777 /export/


