#!/bin/bash

DIR=/docker-entrypoint.d

find / -name "run-parts"



if [[ -d "$DIR" ]]
then
  echo "Running $DIR"
  if [ -a /usr/bin/run-parts ]
  then
    echo "/usr/bin/run-parts $DIR"
    /usr/bin/run-parts $DIR
  else
    if [ -a /bin/run-parts ]
    then
      echo "/bin/run-parts $DIR"
      for file in $DIR/*.sh; do  # Ubuntu requires the filename to be specifc
      # For ex , If neither the --lsbsysinit option nor the --regex option is given then the names must consist entirely of ASCII upper- and lower-case letters, ASCII digits, ASCII underscores, and ASCII minus-hyphens.
        mv "$file" "$DIR/$(basename "$file" .sh)"
      done
      /bin/run-parts $DIR
    else
      run-parts $DIR
      if [ $? -eq 0 ]; then
        echo OK
      else
          echo FAIL
          echo "Cannot find run-parts"
      fi

    fi
  fi
fi


if [ $? -eq 0 ]; then
  echo "Running $@"
  exec "$@"
fi
