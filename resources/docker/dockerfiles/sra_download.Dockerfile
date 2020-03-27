# suggested build command:
# name=sra_download
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG DOCKER_HUB_USER=biolockjdevteam
ARG FROM_VERSION=v1.2.9

FROM ${DOCKER_HUB_USER}/biolockj_controller:${FROM_VERSION}

# 1.) Set shell to bash
SHELL ["/bin/bash", "-c"]
 
# 2.) Install sra-tools
RUN	curl -s https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz | tar xz

# 3.) Configure sra-tools
RUN 	sratoolkit_path=sratoolkit* && \
	$sratoolkit_path/bin/vdb-config --restore-defaults && \
	echo $(echo -n /LIBS/GUID =) \"default\" >> /root/.ncbi/user-settings.mkfg && \
	echo export PATH="$PATH:$PWD/$(echo $sratoolkit_path)/bin" >> /root/.bashrc
