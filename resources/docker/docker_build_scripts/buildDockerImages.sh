#! /bin/bash

cd ${BLJ}
VER=$(cat .version)
TAG=${VER//-*}
DIR=resources/docker/dockerfiles

FILES=$(ls $DIR)
for f in $FILES; do
	name=${f//.Dockerfile}
	echo $name
	docker build -t biolockjdevteam/${name}:${TAG} . -f ${DIR}/${name}.Dockerfile || echo "FAILURE: $name"
done
