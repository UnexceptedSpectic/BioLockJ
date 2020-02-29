# suggested build command:
# name=r_module
# cd ${BLJ}
# docker build -t biolockjdevteam/${name} . -f resources/docker/${name}.Dockerfile 

FROM r-base
ARG DEBIAN_FRONTEND=noninteractive


#1.) Install R Packages
ENV REPO="http://cran.us.r-project.org"
RUN Rscript -e "install.packages('Kendall', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('coin', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('vegan', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('ggpubr', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('properties', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('htmltools', dependencies=TRUE, repos='$REPO')" && \
	Rscript -e "install.packages('stringr', dependencies=TRUE, repos='$REPO')"

#2.) Setup Standard Dirs and Build Standard Directories 
SHELL ["/bin/bash", "-c"]
ENV APP="/app"
ENV APP_BIN="${APP}/bin"
ENV BIN="/usr/local/bin"
ENV BLJ="${APP}/biolockj"
ENV BLJ_MODS="${APP}/external_modules"
ENV EFS="/mnt/efs"
ENV BLJ_CONFIG="${EFS}/config"
ENV BLJ_HOST_HOME="/home/ec2-user"
ENV BLJ_PROJ="${EFS}/pipelines"
ENV BLJ_SCRIPT="${BLJ}/script"
ENV PATH="$PATH:${BLJ_HOST_HOME}/miniconda/bin:${APP_BIN}"
RUN mkdir -p "${BLJ}"              && \
	mkdir -p "${BLJ_PROJ}"         && \
	mkdir "${BLJ_CONFIG}"          && \
	mkdir "${BLJ_SCRIPT}"          && \
	mkdir -p "${BLJ_HOST_HOME}"    && \
	mkdir "${BLJ_MODS}"
	

#3.) Cleanup
RUN	apt-get clean && \
	find / -name *python* | xargs rm -rf && \
	rm -rf /tmp/* && \
	rm -rf /usr/share/* && \
	rm -rf /var/cache/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/log/*
