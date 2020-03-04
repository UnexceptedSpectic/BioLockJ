#! /bin/bash

VER=$(cat ${BLJ}/.version)
TAG=${VER//-*}
DIR=${BLJ}/resources/docker/dockerfiles

FILES=$(cat ${BLJ}/resources/docker/docker_build_scripts/buildOrder.txt)
for f in $FILES; do
	name=${f//.Dockerfile}
	echo "============================"
	echo $name
	docker build -t biolockjdevteam/${name}:${TAG} ${BLJ} -f ${DIR}/${name}.Dockerfile && \
	docker tag biolockjdevteam/${name}:${TAG} biolockjdevteam/${name}:${VER} && \
	docker tag biolockjdevteam/${name}:${TAG} biolockjdevteam/${name}:latest && echo "SUCCESS: $name" 1>&2 || echo "FAILURE: $name" 1>&2
done
