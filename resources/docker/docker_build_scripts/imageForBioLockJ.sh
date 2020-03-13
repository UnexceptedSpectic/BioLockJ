#! /bin/bash

## Make docker images that meet the BioLockJ assumptions

# Environment variables for dirs
BLJ_PROJ="/mnt/efs/pipelines" #required
BLJ_CONFIG="/mnt/efs/config"
BLJ_HOST_HOME="/home/ec2-user"

# assumed directories 
mkdir -p "${BLJ_PROJ}" #required
mkdir -p "${BLJ_CONFIG}"
mkdir -p "${BLJ_HOST_HOME}"

# assumed software 
apt-get update
apt-get install -y build-essential apt-utils bsdtar gawk nano tzdata wget curl

if [ ${#1} -eq 0 ]; then
	PROFILE=~/.bashrc
else
	PROFILE=$1
fi

echo ' ' >> $PROFILE
echo 'export BLJ_PROJ='"$BLJ_PROJ" >> $PROFILE

# maybe required, not sure
echo 'export BLJ_HOST_HOME='"$BLJ_HOST_HOME" >> $PROFILE
echo 'export PATH=$PATH:${BLJ_HOST_HOME}/miniconda/bin:/app/bin' >> $PROFILE

# not required, just nice
echo 'export force_color_prompt=yes' >> $PROFILE
echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> $PROFILE
