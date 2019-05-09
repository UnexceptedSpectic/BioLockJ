# Dockerfile to build a BioLockJ jar file
# From git repo root:
# docker build -t test/blj_builder . -f resources/docker/blj_builder.Dockerfile 

ARG DOCKER_HUB_USER=biolockj
FROM java:8 AS builder

COPY . /blj
ENV ANT_DIST=apache-ant-1.9.14
RUN wget http://apache.mirrors.lucidnetworks.net//ant/binaries/$ANT_DIST-bin.tar.bz2
RUN tar xfj $ANT_DIST-bin.tar.bz2
RUN $ANT_DIST/bin/ant -buildfile blj/resources/build.xml build-jar

FROM $DOCKER_HUB_USER/blj_basic_java
ENV BLJ_MOD_LIB=/modules
RUN mkdir -p $BLJ/dist && \
	mkdir -p $BLJ_PROJ && \
	mkdir -p $BLJ_MOD_LIB
COPY --from=builder /blj/dist/BioLockJ.jar $BLJ/dist/.
COPY --from=builder /blj/script $BLJ/script
COPY --from=builder /blj/resources $BLJ/resources
COPY --from=builder /blj/.version /blj/install $BLJ/

RUN $BLJ/install

#CMD java -jar $BLJ/dist/BioLockJ.jar $BLJ_OPTIONS
CMD java -cp $BLJ_MOD_LIB:$BLJ/dist/BioLockJ.jar biolockj.BioLockJ $BLJ_OPTIONS

# docker run \
#	-e BLJ_OPTIONS="-b <host output dir> -C <host config dir> -c <config file> -i <host input dir>" \
#	-v /var/run/docker.sock:/var/run/docker.sock 
#	-v <host input dir>:/input 
#	-v <host output dir>:/pipelines:delegated 
#	-v <host config dir>:/config 
#	[-v <host module library>:/modules]
#	biolockj/blj_builder