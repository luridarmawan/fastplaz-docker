#!/bin/bash
# Usage: ./build.sh [ubuntu] [runtime] [--push]
#   default : build image for the local platform  -> fastplaz/<os>:latest
#   --push  : build multi-arch (amd64, arm64) and push -> fastplaz/<os>:latest + :multiarch
echo Docker - FastPlaz Image Generator

PUSH=0
ARGS=()
for a in "$@"; do
	if [ "$a" == "--push" ]; then PUSH=1; else ARGS+=("$a"); fi
done

OS=${ARGS[0]:-ubuntu}
RELEASE=""
if [ "${ARGS[1]}" == "runtime" ] && [ "$OS" != "ubuntu" ]; then
	RELEASE="-runtime"
fi
IMAGE="fastplaz/$OS$RELEASE"
DOCKERFILE="Dockerfile-$OS$RELEASE"
echo Build: $IMAGE

cd "$(dirname "$0")/files/" || exit 1

if [ ! -f "$DOCKERFILE" ]; then
	echo "Error: files/$DOCKERFILE tidak ditemukan!"
	exit 1
fi

if [ "$PUSH" == "1" ]; then
	# Build & push multi-arch Docker image
	docker buildx build -f "$DOCKERFILE" --platform linux/amd64,linux/arm64 \
		-t "$IMAGE:latest" -t "$IMAGE:multiarch" --push .
else
	# Build for local platform and load into local docker
	docker build -f "$DOCKERFILE" -t "$IMAGE:latest" .
fi
