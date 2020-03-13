# suggested build command:
# name=blj_basic_py2
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9
FROM ${DOCKER_HUB_USER}/blj_basic:${FROM_VERSION}
ARG DEBIAN_FRONTEND=noninteractive

#1.) Install Ubuntu Software 
RUN apt-get update && apt-get install -y python2.7-dev python-pip python-tk 
	
#2.) Cleanup
RUN	rm -rf /tmp/* && rm -rf /var/log/* 
