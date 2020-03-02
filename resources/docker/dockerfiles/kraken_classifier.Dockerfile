# suggested build command:
# name=kraken_classifier
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9
FROM ${DOCKER_HUB_USER}/kraken_classifier_dbfree:${FROM_VERSION}

#1.) Download 8GB Dustmasked miniKraken DB
RUN BLJ_DEFAULT_DB=/mnt/db && \
	mkdir ${BLJ_DEFAULT_DB} && \
	cd "${BLJ_DEFAULT_DB}" && \
	wget "https://ccb.jhu.edu/software/kraken/dl/minikraken_20171101_8GB_dustmasked.tgz" && \
	md5sum minikraken_20171101_8GB_dustmasked.tgz && \
	bsdtar -xzf minikraken_20171101_8GB_dustmasked.tgz && \
	mv minikraken*/* . && \
	rm -rf minikraken* && \
	chmod -R 777 "${BLJ_DEFAULT_DB}"

#2.) Cleanup
RUN	 rm -rf /usr/share/* 
