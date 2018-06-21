#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

if [ -f /etc/redhat-release ]; then  # Centos
  major_version=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
elif [ -f /etc/lsb-release ]; then # Ubuntu
  major_version=$(OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/lsb-release`)
fi

CUR_DIR=`pwd`
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
export INSTALLDIR=/tmp

/usr/local/bin/startGPDB.sh
#

echo "Untar madlib package"
export madlib_file=`ls $INSTALLDIR/madlib*.tar.gz`
cd $INSTALLDIR
tar -xvf $madlib_file
mv $INSTALLDIR/madlib-*-gp5-rhel7-x86_64/madlib*.gppkg /tmp
chown -R gpadmin:gpadmin /tmp/*


echo "Find madlib package"
export in_file=`ls $INSTALLDIR/madlib*.gppkg`
export out_file="$(echo $in_file | sed 's=.*/==;s/\.[^.]*$/.gppkg/')"
runuser -l gpadmin -c "cd ${INSTALLDIR};gppkg --install ${out_file}"

cd $CUR_DIR
