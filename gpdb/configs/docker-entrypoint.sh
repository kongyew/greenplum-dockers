#!/bin/bash

DIR=/docker-entrypoint.d

#find / -name "run-parts"

if [[ -d "$DIR" ]]
then
  echo "Running $DIR"
  /usr/bin/run-parts $DIR
fi


if [ $? -eq 0 ]; then
  echo "Running $@"
  exec "$@"
fi
