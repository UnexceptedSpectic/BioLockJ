# suggested build command:
# name=metaphlan2_classifier_dbfree
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG FROM_VERSION=latest
FROM python:${FROM_VERSION}

#1.) set shell to bash
SHELL ["/bin/bash", "-c"]

#2.) Copy script that has the BioLockJ assumptions
COPY resources/docker/docker_build_scripts/imageForBioLockJ.sh /root/.

#3.) Build Standard Directories and varibles and assumed software
RUN . /root/imageForBioLockJ.sh ~/.bashrc

#4.) Install dependencies
RUN pip install numpy && \
	pip install biopython && \
	pip install cython && \
	pip install biom-format

#5.) Install bowtie 2.3.4.3
ENV BIN=/usr/bin
RUN BASE_URL="https://github.com/BenLangmead/bowtie2/releases/download/v" && \
	BOWTIE_VER=2.3.4.3 && \
	BOWTIE=bowtie2-${BOWTIE_VER}-linux-x86_64 && \
	BOWTIE_URL=${BASE_URL}${BOWTIE_VER}/${BOWTIE}.zip && \
	cd $BIN && wget -qO- $BOWTIE_URL | bsdtar -xf- && \
	chmod o+x -R $BIN/$BOWTIE && \
	rm -rf $BIN/$BOWTIE/*-debug && \
	mv $BIN/$BOWTIE/[bs]* . && \
	rm -rf $BIN/$BOWTIE

#6.) Install MetaPhlAn2
RUN mpa_dir=$BIN && \
	MP_URL="https://bitbucket.org/biobakery/metaphlan2/get/default.zip" && \
	cd $BIN && \
	wget -qO- $MP_URL | bsdtar -xf- && \
	mv biobakery*/* . && \
	rm -rf biobakery*  && \
	chmod o+x -R *.py && \
	ln -s metaphlan2.py metaphlan2
	
#7.) Cleanup
RUN	apt-get clean && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/log/*

#8.) Remove shares (except ca-certificates) to allow internet downloads
RUN	mv /usr/share/ca-certificates* ~ && \
	rm -rf /usr/share/* && \
	mv ~/ca-certificates* /usr/share