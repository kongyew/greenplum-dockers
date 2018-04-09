#!/bin/bash
# Including configurations

mc config host add minio http://localhost:9001 minio minio123;
mc rm --recursive --force minio/testbucket;
mc mb minio/testbucket;
mc cp S3Examples/stocks.csv minio/testbucket;
mc cp S3Examples/testdata.csv minio/testbucket;
mc cp S3Examples/read_stocks.sql minio/testbucket;
mc policy download minio/testbucket;
