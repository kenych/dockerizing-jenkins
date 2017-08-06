#!/usr/bin/env bash

#get needed stuff 1st
./download.sh

#update with actual password
echo "password" > ./secrets/artifactoryPassword

#update older jenkins image, make sure it doesnt use cache
docker-compose build --no-cache

#run all
docker-compose up