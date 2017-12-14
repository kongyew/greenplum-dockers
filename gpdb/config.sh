#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Greenplum
export CONTAINER_NAME="gpdbsne"

export DOCKER_LABEL="GPDB 5"
export DOCKER_TAG="kochan/gpdb5"
export DOCKER_LATEST_TAG="kochan/gpdb5:latest"
export GPDB_VERSION="5.2.0-rhel6-x86_64"

export DOCKER_PXF_LABEL="GPDB 5-PXF"
export DOCKER_PXF_TAG="kochan/gpdb5-pxf:latest"

# Madlib
export DOCKER_MADLIB_LABEL="GPDB5-madlib"
export DOCKER_MADLIB_TAG="kochan/gpdb5-madlib:latest"
