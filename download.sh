#!/usr/bin/env bash

#clean anything with same name to get rid of clashes
docker-compose down

docker pull kayan/myjenkins:latest
