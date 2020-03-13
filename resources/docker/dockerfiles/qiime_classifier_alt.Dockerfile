# suggested build command:
# name=qiime_classifier
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

ARG FROM_VERSION=latest
FROM continuumio/miniconda3:${FROM_VERSION}

#1.) set shell to bash
SHELL ["/bin/bash", "-c"]

#2.) Copy script that has the BioLockJ assumptions
COPY resources/docker/docker_build_scripts/imageForBioLockJ.sh /root/.

#3.) Build Standard Directories and varibles and assumed software
RUN . /root/imageForBioLockJ.sh ~/.bashrc

#) Create qiime conda env
#RUN apt-get install -y python-matplotlib
#RUN conda install -c astropy-ci-extras matplotlib
RUN conda config --append channels astropy-ci-extras

RUN conda create -n qiime1 python=2.7 qiime matplotlib=1.4.3 mock nose -c bioconda

#RUN conda config --set allow_conda_downgrades true
#RUN conda install conda=4.6.14
#RUN conda install matplotlib=1.4.3
#RUN conda create -n qiime1 python=2.7 qiime mock nose -c bioconda
#RUN conda create -n env python=3.6
RUN echo "source activate qiime1" > ~/.bashrc
RUN print_qiime_config.py -t
ENV PATH /opt/conda/envs/env/bin:$PATH




#4.) Install dependencies
#RUN pip install numpy && \
#	pip install cython && \
#	pip install biom-format

#5.) Install numpy/QIIME + QIIME Default DB
#RUN pip install qiime

#6.) Install vSearch
#ENV BIN=/usr/bin
#RUN BASE_URL="https://github.com/torognes/vsearch/releases/download/v" && \
#	VSEARCH_VER="2.8.1" && \
#	VSEARCH="vsearch-${VSEARCH_VER}-linux-x86_64" && \
#	V_URL="${BASE_URL}${VSEARCH_VER}/${VSEARCH}.tar.gz" && \
#	cd $BIN && wget -qO- ${V_URL} | bsdtar -xzf- && \
#	mv vsearch*/bin/* . && rm -rf ${VSEARCH}
#ENV PATH=${BIN}:${PATH}





#7.) Cleanup
RUN	apt-get clean && \
	rm -rf /tmp/* && \
	rm -rf /usr/share/* && \
	rm -rf /var/cache/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/log/*
