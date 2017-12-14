###########################
 Setup Greenplum and Spark
###########################

This page describes how to setup Greenpum and Spark dockers

Pre-requisites:
=================================================================
- `docker compose <http://docs.docker.com/compose>`_ 
- `Greenplum Spark connector <http://greenplum-spark.docs.pivotal.io/100/index.html>`_ 
- `Postgres JDBC driver <https://jdbc.postgresql.org/download/postgresql-42.1.4.jar>`_ - if you want to write data from Spark into Greenplum.


Using docker-compose
=================================================================
To create a standalone Greenplum cluster with the following command in the root directory.
It builds a docker image with Pivotal Greenplum binaries and download some existing images such as Spark master and worker. Initially, it may take some time to download the docker image.

.. code-block:: bash

    $ runGPDBSpark2-1.sh
    docker_master_1 is up-to-date
    Creating docker_gpdb_1 ...
    Creating docker_worker_1 ...
    Creating docker_gpdb_1
    Creating docker_gpdb_1 ... done


The SparkUI will be running at `http://localhost:8080` with one worker listed.


Setup Greenplum with sample tables
=================================================================
Click on the section "Create database and table"

Connect to Spark master instance
=================================================================

1. Connect to the Spark master docker image

.. code-block:: bash

  $ docker exec -it docker_master_1 /bin/bash

Connect to Greenplum instance
=================================================================

1. Connect to the GPDB docker image

.. code-block:: bash

  $ docker exec -it docker_gpdb_1 /bin/bash