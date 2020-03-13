# suggested build command:
# name=r_module
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/dockerfiles/${name}.Dockerfile 

FROM r-base
ARG DEBIAN_FRONTEND=noninteractive

#1.) set shell to bash
SHELL ["/bin/bash", "-c"]

#2.) Copy script that has the BioLockJ assumptions
COPY resources/docker/docker_build_scripts/imageForBioLockJ.sh /root/.

#3.) Build Standard Directories and varibles and assumed software
RUN . /root/imageForBioLockJ.sh ~/.bashrc

#4.) Install R Packages
RUN REPO="http://cran.us.r-project.org" && \
	Rscript -e "install.packages('Kendall', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('coin', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('vegan', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('ggpubr', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('properties', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('htmltools', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('stringr', dependencies=TRUE, repos='$REPO')"

#5.) Cleanup
RUN	apt-get clean && \
	find / -name *python* | xargs rm -rf && \
	rm -rf /tmp/* && \
	rm -rf /usr/share/* && \
	rm -rf /var/cache/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/log/*
