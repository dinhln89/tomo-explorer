#!/bin/bash

service_name=$1

git fetch origin && git checkout origin/master
wait

if [ "${service_name}" == "all" ] || [ "${service_name}" == "" ];
then
  docker-compose -f docker-compose-prod.yml build && \
    docker-compose -f docker-compose-prod.yml stop && \
    docker-compose -f docker-compose-prod.yml up -d && \
    bash ./clean.sh
else
  for n in $@
  do
    docker-compose -f docker-compose-prod.yml build ${n} && \
      docker-compose -f docker-compose-prod.yml stop ${n} && \
      docker-compose -f docker-compose-prod.yml up -d ${n}
  done
  bash ./clean.sh
fi
