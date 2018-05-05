#!/bin/bash

check_stat=`ps -ef | grep 'gunicorn' | awk '{print $2}'`
if [ -n "$check_stat" ]
then
   echo "gunicorn is running"

else
   echo "gunicorn isn't running"

fi


# Create an admin user (you will be prompted to set username, first and last name before setting a password)
fabmanager create-admin --app superset

# Initialize the database
superset db upgrade

# Load some data to play with
superset load_examples

# Create default roles and permissions
superset init
