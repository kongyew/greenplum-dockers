# Readme
This document describes how to create docker images for Greenplum and using docker-compose to use Greenplum docker(s) with other dockers such as Cloudera, Hortonworks and others
<https://pivotal.io/pivotal-greenplum>

## Pre-requisites:
- [docker-compose](http://docs.docker.com/compose)

## Download Greenplum binaries
This section describes how to automaically download Pivotal Greenplum binaries from Pivotal Network. It uses this [tool](https://github.com/kongyew/greenplum-downloader/).
Internally, it depends on Pivotal API, in order to retrieve the list of files associated to a particular Greenplum release.


##
