# suggested build command:
# name=humann2_classifier
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9
FROM ${DOCKER_HUB_USER}/metaphlan2_classifier_dbfree:${FROM_VERSION}
ARG DEBIAN_FRONTEND=noninteractive

#1.) Install HumanN2 + dependencies
RUN pip install humann2
