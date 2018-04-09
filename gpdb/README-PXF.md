# Building Greenplum docker images
You can use these scripts to build Greenplum docker files for 4.3.x , 5.x and Open Source.


# Building the Docker Image with Pivotal Network binaries
## Pre-requisites:
- Docker-compose
- Pivotal Greenplum binaries.

## Downloading Pivotal Greenplum binaries
Follow the instructions under the folder greenplum_downloaders

## Building docker image for Centos or SUSE
You can build Greenplum docker image with Centos 7 by using "build_docker.sh"
```
$ ./build_docker.sh -i 5.4.1-rhel6-x86_64
```

You can build Greenplum docker image with Centos 7 by using "build_docker.sh"
```
$ ./build_docker.sh -i sles11-x86_64
```
## Configure Greenplum with Platform Extension Framework (PXF)

$ ./build_docker-pxf.sh
...
SSHD isn't running
SSHD is running...
20180130:21:45:22:000052 gpstart:gpdbsne:gpadmin-[INFO]:-Starting gpstart with args: -a
20180130:21:45:22:000052 gpstart:gpdbsne:gpadmin-[INFO]:-Gathering information and validating the environment...
20180130:21:45:22:000052 gpstart:gpdbsne:gpadmin-[INFO]:-Greenplum Binary Version: 'postgres (Greenplum Database) 5.4.1 build commit:4eb4d57ae59310522d53b5cce47aa505ed0d17d3'
20180130:21:45:22:000052 gpstart:gpdbsne:gpadmin-[INFO]:-Greenplum Catalog Version: '301705051'
```

# Building the Docker Image with Open Source repository
You can build Greenplum docker image with Ubuntu and Greenplum Open Source repository.

The build_docker.sh is used to build Greenplum OSS. Internally, it uses DockerfileOpenSource that depends on Ubuntu.
```
$ ./build_docker.sh -i opensource
Type for Parameter: opensource
Variable opensource exists!
Building Open Source docker for opensource
Sending build context to Docker daemon ...
...
Commit docker image
sha256:ba58f8911e613018345133bdf54003b9fb051c27d71b843a31fa20e0532089a2
```

##  Running the OSS Docker Image
You can run Greenplum OSS docker image by following the command below.
```
$ ./run_ossdocker.sh
/bin/run-parts
Running /docker-entrypoint.d
Running bin/bash
root@gpdbsne:/#
```
By default, Greenplum instance is not started. You can use these scripts to start/stop Greenplum "startGPDB.sh" and stopGPDB.sh".

```
root@gpdbsne:/# startGPDB.sh
SSHD isn't running
 * Starting OpenBSD Secure Shell server sshd                                 [ OK ]
SSHD is running...
20180130:20:06:12:000068 gpstart:gpdbsne:gpadmin-[INFO]:-Starting gpstart with args: -a
20180130:20:06:12:000068 gpstart:gpdbsne:gpadmin-[INFO]:-Gathering information and validating the environment
...
20180130:20:06:12:000068 gpstart:gpdbsne:gpadmin-[INFO]:-Greenplum Binary Version: 'postgres (Greenplum Database) 5.4.1 build
...
20180130:20:06:19:000247 gpstart:gpdbsne:gpadmin-[ERROR]:-gpstart error: Master instance process running
root@gpdbsne:/#
```
