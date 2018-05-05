#!/bin/bash
# Including configurations
. config.sh

set -e



docker run --restart on-failure -p 18630:18630 -d --name streamsets-dc streamsets/datacollector
# The default username and password are "admin" and "admin".
