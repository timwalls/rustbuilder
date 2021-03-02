#!/bin/sh

PLATFORMS=linux/amd64,linux/arm/v7,linux/arm64
IMAGE=snowgoons/rustbuilder
TAG=latest

docker buildx use xplatform-builder
docker buildx build --platform ${PLATFORMS} -t ${IMAGE}:${TAG} --push .
