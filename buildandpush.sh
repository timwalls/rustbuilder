#!/bin/sh

PLATFORMS=linux/amd64,linux/arm/v7,linux/arm64

IMAGE=snowgoons/rustbuilder
TAG=rustc-1.64.0

docker buildx rm rustbuilder-builder || true
docker buildx create --name rustbuilder-builder
docker buildx create --append --name rustbuilder-builder --platform linux/amd64   hp-node0
docker buildx create --append --name rustbuilder-builder --platform linux/arm/v7  pisicuta
docker buildx create --append --name rustbuilder-builder --platform linux/arm64   arm-node0

docker buildx use rustbuilder-builder
docker buildx build --platform ${PLATFORMS} -t ${IMAGE}:${TAG} --push .
