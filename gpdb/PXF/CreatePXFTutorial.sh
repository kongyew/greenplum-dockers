#!/bin/bash
# reference :https://gpdb.docs.pivotal.io/510/pxf/cfginitstart_pxf.html
if [[ ! "$(whoami)" =~ ^(gpadmin|root)$ ]]
then
    echo "Please run the script as gpadmin or root" >&2
    exit 1
fi

# function ExecuteAsRoot(){
#
# }
export TESTDB=testdb

echo "Create testdb for this tutorial"
createdb $TESTDB


echo "Create extension PXF to enable PXF"
psql -d $TESTDB -U gpadmin -c "CREATE EXTENSION pxf;"

echo "Create user for PXF"
#createuser -P PXFuser --no-createdb --login --no-createrole --no-superuser
psql -d $TESTDB -U gpadmin -c "CREATE USER PXFuser WITH PASSWORD 'pivotal' NOSUPERUSER;"

echo "Create user for PXF"
psql -d $TESTDB -U gpadmin -c "GRANT SELECT ON PROTOCOL pxf TO PXFuser;"
