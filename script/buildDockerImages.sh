#! /bin/bash

cd ${BLJ}
VER=$(cat .version)
TAG=${VER//-*}

FILES=$(ls resources/docker)
for f in $FILES; do
	name=${f//.Dockerfile}
	echo $name
	docker build -t biolockjdevteam/${name}:${TAG} . -f resources/docker/${name}.Dockerfile || echo "FAILURE: $name"
done
