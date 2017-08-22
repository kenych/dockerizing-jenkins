#!/usr/bin/env bash

#get needed stuff 1st
./download.sh

#clean anything with same name to get rid of clashes
docker-compose down
docker-compose -f docker-compose-elk.yml down

#update with actual password
echo "password" > ./secrets/artifactoryPassword

#update older jenkins image, make sure it doesnt use cache
docker-compose build --no-cache

#run build stack
docker-compose up &

#run elk stack
docker-compose -f docker-compose-elk.yml up