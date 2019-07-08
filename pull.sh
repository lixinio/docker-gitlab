#!/bin/bash

set -e

if [ $# -ne 1 ]; then
  echo "usage: pull.sh images.txt"
  exit 1
fi

while IFS='' read -r image || [[ -n "$image" ]]; do
  src=registry.gitlab.com/gitlab-org/build/cng/$image
  target=lixinio/$image
  echo "Pulling $src ..."
  docker pull $src
  docker tag $src $target
  docker push $target
done < "$1"
