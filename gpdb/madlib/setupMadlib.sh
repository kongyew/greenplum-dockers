#!/bin/bash
set -e

check_stat=`ps -ef | grep '[s]shd' | awk '{print $2}'`
if [ -n "$check_stat" ]
then
   echo "SSHD is running"

else
   echo "SSHD isn't running"
   service sshd start
fi
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
export INSTALLDIR=/tmp

#
echo "Untar madlib package"
export madlib_file=`$INSTALLDIR/ls madlib*.tar.gz`
tar -xvf $madlib_file

echo "Find madlib package"
export out_file="$(echo $in_file | sed 's=.*/==;s/\.[^.]*$/.gppkg/')"
gppkg $out_file
