#!/usr/bin/env bash

#clean anything with same name to get rid of clashes
docker-compose down

docker pull jenkins:2.60.1
docker pull sonarqube:6.3.1
docker pull docker.bintray.io/jfrog/artifactory-oss:5.4.4

if [ ! -d downloads ]; then
    mkdir downloads
#    curl -o downloads/jdk-8u131-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u131-linux-x64.tar.gz
    curl -o downloads/apache-maven-3.5.0-bin.tar.gz http://apache.mirror.anlx.net/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
fi