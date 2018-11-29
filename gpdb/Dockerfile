#
#  Dockerfile for a GPDB Image
#
#FROM centos:6.9
#FROM centos:7.4.1708
FROM centos/systemd:latest

# Argument
ARG build_env=test
ARG GPDB_VERSION="5.13.0-rhel6-x86_64"
ARG GPDB_DOWNLOAD="greenplum-downloader/DOWNLOAD_5.13.0"

# Passing argument to this env variable inside your Dockerfile:
ENV GPDB_VERSION=$GPDB_VERSION
ENV GPDB_DOWNLOAD=$GPDB_DOWNLOAD
################################################################################
COPY ${GPDB_DOWNLOAD}/greenplum-db-${GPDB_VERSION}.zip /tmp
#COPY ${GPDB_DOWNLOAD}/pljava-*gp5-rhel6-x86_64.gppkg /tmp
#COPY ${GPDB_DOWNLOAD}/pljava-1.4.2-gp5-rhel6-x86_64.gppkg /tmp

# COPY ${GPDB_DOWNLOAD}/madlib-1.15.1-gp5-rhel7-x86_64.tar.gz /tmp
COPY ${GPDB_DOWNLOAD}/greenplum-cc-web-*.*-LINUX-x86_64.zip /tmp
# COPY ${GPDB_DOWNLOAD}/greenplum-text-*-rhel6_x86_64.tar.gz /tmp


COPY configs /opt/configs/
COPY PXF    /opt/PXF/
COPY madlib    /opt/madlib/
COPY dblink    /opt/dblink/
#COPY pl_java    /opt/pl_java/
COPY gphdfs    /opt/gphdfs/
COPY gpcc    /opt/gpcc/
COPY ansible /opt/ansible/

################################################################################
#
# Default RPM
################################################################################
RUN echo root:pivotal | chpasswd \
    && yum install -y vim wget unzip which tar more util-linux-ng passwd \
     openssh-clients openssh-server ed m4 sudo krb5-libs krb5-workstation \
     cronie cronie-anacron iproute net-tools less \
     epel-release ansible \
    && unzip  /tmp/greenplum-db-${GPDB_VERSION}.zip -d /tmp/ \
    && rm /tmp/greenplum-db-${GPDB_VERSION}.zip \
    && sed -i s/"more << EOF"/"cat << EOF"/g /tmp/greenplum-db-${GPDB_VERSION}.bin \
    && echo -e "yes\n\nyes\nyes\n" | /tmp/greenplum-db-${GPDB_VERSION}.bin \
    && ln -s /usr/local/greenplum-db /usr/local/greenplum-db-devel \
    && cat /opt/configs/sysctl.conf.add >> /etc/sysctl.conf \
    && cat /opt/configs/limits.conf.add >> /etc/security/limits.conf \
    && cp /opt/configs/*.sh /usr/local/bin/ \
    && chmod +x /usr/local/bin/*.sh \
    && chmod +x /opt/PXF/*.sh \
    && cp /opt/PXF/*.sh /usr/local/bin \
    && /usr/sbin/groupadd gpadmin \
        && /usr/sbin/useradd gpadmin -g gpadmin -G wheel \
        && echo "pivotal"|passwd --stdin gpadmin \
        && echo "gpadmin        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers \
        && mv /opt/configs/bash_profile /home/gpadmin/.bash_profile \
        && mv /opt/configs/bashrc_template /home/gpadmin/.bashrc \
        && chown -R gpadmin: /home/gpadmin \
        && mkdir -p /gpdata/master /gpdata/segments \
        && chown -R gpadmin: /gpdata \
        && chown -R gpadmin: /usr/local/green* \
        && chown -R gpadmin:gpadmin /usr/local/greenplum-db-devel \
      && ssh-keygen -f /root/.ssh/id_rsa -N '' \
      && cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys \
      && mkdir -p /home/gpadmin/.ssh  \
      && cat /root/.ssh/id_rsa.pub >> /home/gpadmin/.ssh/authorized_keys \
      && cp /root/.ssh/id_rsa /root/.ssh/id_rsa.pub /home/gpadmin/.ssh/  \
      && chown gpadmin:gpadmin -R /home/gpadmin/.ssh \
      && echo "gpdbsne" > /tmp/gpdb-hosts \
      && cp /opt/configs/gpinitsystem_singlenode /tmp \
      && chmod 777 /tmp/gpinitsystem_singlenode \
      && hostname > ~/orig_hostname \
      && hostname > /tmp/orig_hostname \
      && echo "127.0.0.1 gpdbsne gpdbsne.localdomain" >> /etc/hosts \
      && su -c gpadmin -c "echo 'source /usr/local/greenplum-db/greenplum_path.sh' >> .bashrc" \
      && su -c gpadmin -c "echo 'export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1' >> .bashrc" \
      && rm -f /tmp/greenplum-db-${GPDB_VERSION}.bin \
      && yum clean all \
      && rm -rf /var/cache/yum
################################################################################
EXPOSE 5432 22
EXPOSE 40000 40001 40002

VOLUME /data
# Set the default command to run when starting the container
RUN   systemctl enable sshd.service
################################################################################
# Default entry point
# Files under /docker-entrypoint.d/ will be executed
################################################################################
COPY configs/docker-entrypoint.sh /
COPY docker-entrypoint.d/* /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.sh \
&& chmod +x /docker-entrypoint.d/*.sh

ONBUILD COPY /docker-entrypoint.d/* /docker-entrypoint.d/
# Run all the scripts
ENTRYPOINT ["/docker-entrypoint.sh"]

# Default command
CMD ["bin/bash"]
################################################################################
