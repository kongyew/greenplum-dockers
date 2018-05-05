# Readme
This document describes how to create docker images for Greenplum and using docker-compose to use Greenplum docker(s) with other dockers such as Cloudera, Hortonworks and others
<https://pivotal.io/pivotal-greenplum>

## Pre-requisites:
- [docker-compose](http://docs.docker.com/compose)

## Download Greenplum binaries
This section describes how to automaically download Pivotal Greenplum binaries from Pivotal Network. It uses this [tool](https://github.com/kongyew/greenplum-downloader/).
Internally, it depends on Pivotal API, in order to retrieve the list of files associated to a particular Greenplum release.

For more details, click [here](gpdb/README.md)

## How to run GPDB with Cloudera
This example works once you have downloaded GPDB binaries from Pivnet and build a docker image. For more details, click [here](gpdb/README.md)

For more details to download GPDB from Pivnet, click [here](gpdb/greenplum-downloader/README.md)

Run GPDB and Cloudera instance:
```
$ ./runDocker.sh -t cloudera -c up
```

Stop GPDB and Cloudera instance:
```
$ ./runDocker.sh -t cloudera -c down
```

## How to run GPDB - PXF to access Postgres DB - 9.6
This example works once you have downloaded GPDB binaries from Pivnet and build a docker image. For more details, click [here](gpdb/README.md)

For more details to download GPDB from Pivnet, click [here](gpdb/greenplum-downloader/README.md)

```
$ ./runDocker.sh -t postgres9.6 -c up
```
