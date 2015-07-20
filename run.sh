#!/bin/sh

REDIS_IMAGE=quay.io/viadeo/docker-redis
REDIS_NAME=redis
TEST_IMAGE=redis-python-tester

# Build images
echo "Building $REDIS_IMAGE"
docker build -t $REDIS_IMAGE .
echo "Building $TEST_IMAGE"
docker build -t $TEST_IMAGE test

# Run main container
docker kill $REDIS_NAME
docker run --rm -p 6379:6379 --name=$REDIS_NAME $REDIS_IMAGE &
sleep 1

# Run tester container
docker run --rm --link=$REDIS_NAME:$REDIS_NAME $TEST_IMAGE

# Stop main container
docker stop $REDIS_NAME
