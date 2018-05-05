FROM centos:centos7


# Pre-requisites
# Get any CentOS updates then clear the Docker cache
RUN yum -y update && yum clean all

# Install MarkLogic dependencies
RUN yum -y install glibc.i686 gdb.x86_64 redhat-lsb.x86_64 && yum clean all

# Install the initscripts package so MarkLogic starts ok
RUN yum -y install initscripts && yum clean all

# Set the Path
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/MarkLogic/mlcmd/bin


# Install MarkLogic
ADD MarkLogic-9.0-4.x86_64.rpm /tmp/MarkLogic.rpm
RUN yum -y install /tmp/MarkLogic.rpm

# Include MarkLogic's libs
ENV LD_LIBRARY_PATH /opt/MarkLogic/lib

# Expose MarkLogic Server ports
# 8000 : Query console
# 8001 : Admin
# 8002 : Management/monitoring
# 8010 : (custom database) Rest api
# 8011 : (custom database) Xcc connector (deploiment...)
EXPOSE 8000 8001 8002 8010 8011

# Run and don't stop

# Start MarkLogic from init.d script.
# Define default command (which avoids immediate shutdown)
CMD /etc/init.d/MarkLogic start && tail -f /dev/null
# CMD /opt/MarkLogic/bin/MarkLogic && tail -f /var/opt/MarkLogic/Logs/ErrorLog.txt
