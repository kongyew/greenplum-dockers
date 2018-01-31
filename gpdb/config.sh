#!/bin/bash
#
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export BUILD_ENV="test"  # only 1 option for now.
# Greenplum
export CONTAINER_NAME="gpdbsne"

export DOCKER_OSS_LABEL="GPDB 5 OSS"
export DOCKER_OSS_TAG="kochanpivotal/gpdb5oss"
export DOCKER_LATEST_OSS_TAG="kochanpivotal/gpdb5oss:latest"


export DOCKER_LABEL="GPDB 5"
export DOCKER_TAG="kochanpivotal/gpdb5"
export DOCKER_LATEST_TAG="kochanpivotal/gpdb5:latest"

# CHANGEME to build different GPDB version
export GPDB_VERSION="5.4.1-rhel6-x86_64"
export GPDB_SUSE_VERSION="5.4.1-sles11-x86_64"

export GPDB_DOWNLOAD="greenplum-downloader/DOWNLOAD_5.4.1"

export DOCKER_PXF_LABEL="GPDB 5-PXF"
export DOCKER_PXF_TAG="kochanpivotal/gpdb5-pxf"

# Madlib
export DOCKER_MADLIB_LABEL="GPDB5-madlib"
export DOCKER_MADLIB_TAG="kochanpivotal/gpdb5-madlib:latest"
