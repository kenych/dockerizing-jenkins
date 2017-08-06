#!/usr/bin/env bash

function getContainerPort() {
    echo $(docker port $1 | sed 's/.*://g')
}

docker pull jenkins:2.60.1
docker pull sonarqube:6.3.1

if [ ! -d downloads ]; then
    mkdir downloads
    curl -o downloads/jdk-8u131-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u131-linux-x64.tar.gz
    curl -o downloads/jdk-7u76-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u76-linux-x64.tar.gz
    curl -o downloads/apache-maven-3.5.0-bin.tar.gz http://apache.mirror.anlx.net/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
fi

docker stop mysonar myjenkins artifactory 2>/dev/null

docker build -t myjenkins .

docker run -d -p 9000 --rm --name mysonar sonarqube:6.3.1

docker run  -d --rm -p 8081 --name artifactory  docker.bintray.io/jfrog/artifactory-oss:5.4.4

sonar_port=$(getContainerPort mysonar)
artifactory_port=$(getContainerPort artifactory)

IP=$(ifconfig en0 | awk '/ *inet /{print $2}')

if [ ! -d m2deps ]; then
    mkdir m2deps
fi

docker run -d -p 8080 -v `pwd`/downloads:/var/jenkins_home/downloads \
    -v `pwd`/jobs:/var/jenkins_home/jobs/ \
    -v `pwd`/m2deps:/var/jenkins_home/.m2/repository/ --rm --name myjenkins \
    -e SONARQUBE_HOST=http://${IP}:${sonar_port} \
    -e ARTIFACTORY_URL=http://${IP}:${artifactory_port}/artifactory/example-repo-local \
    myjenkins:latest

echo "Sonarqube is running at http://${IP}:${sonar_port}"
echo "Artifactory is running at http://${IP}:${artifactory_port}"
echo "Jenkins is running at http://${IP}:$(getContainerPort myjenkins)"

