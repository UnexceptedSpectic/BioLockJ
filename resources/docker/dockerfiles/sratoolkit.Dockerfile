# suggested build command:
# name=sratoolkit
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9

FROM ${DOCKER_HUB_USER}/blj_basic:${FROM_VERSION}

ARG DEBIAN_FRONTEND=noninteractive

# 1.) Install sra-tools
RUN	curl -s https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz | tar xz

# 2.) Configure sra-tools
RUN mv sratoolkit* /sratools && \
	/sratools/bin/vdb-config --restore-defaults && \
	echo $(echo -n /LIBS/GUID =) \"default\" >> ~/.ncbi/user-settings.mkfg 
	
# 3.) Add to path
ENV PATH=$PATH:/sratools/bin
