#!/bin/bash
set -x # debugging

dd if=/dev/zero of=sda bs=1024 count=1024
dd if=/dev/zero of=sdb bs=1024 count=1024



#/opt/mapr/server/mrconfig sp list
