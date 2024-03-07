#!/bin/sh
read -p "Enter the tag (e.g. v9.0.3-1): " tag
docker build  . -f Dockerfile.base -t eivarin/dockerizedcoreemu:$tag
docker push eivarin/dockerizedcoreemu:$tag