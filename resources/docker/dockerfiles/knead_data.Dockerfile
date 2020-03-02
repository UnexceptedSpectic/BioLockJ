# suggested build command:
# name=knead_data
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9
FROM ${DOCKER_HUB_USER}/knead_data_dbfree:${FROM_VERSION}

#1.) Install kneaddata human DNA contaminant DB
RUN kneaddata_database --download human_genome bowtie2 "${BLJ_DEFAULT_DB}"

#2.) Cleanup
RUN	rm -rf /usr/share/*
