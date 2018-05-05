###############################################################################

FROM alpine:latest
MAINTAINER Kong

ARG ALLUXIO_VERSION=1.7.0

ENV PATH $PATH:/alluxio/bin

LABEL Description="Alluxio" \
      "Alluxio Version"="$ALLUXIO_VERSION"

WORKDIR /

# OpenJDK8 recent versions give error:
#
# org.apache.jasper.JasperException: PWC6033: Error in Javac compilation for JSP PWC6199: Generated servlet error: The type java.io.ObjectInputStream cannot be resolved. It is indirectly referenced from required .class files
#
# use OpenJDK7 instead
RUN set -euxo pipefail && \
    # needs a full JDK now for master, not just JRE
    apk add --no-cache bash openjdk7 sudo

RUN set -euxo pipefail && \
    apk add --no-cache wget tar && \
    wget -t 100 --retry-connrefused -O "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" "http://alluxio.org/downloads/files/${ALLUXIO_VERSION}/alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    tar zxf "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    rm -fv "alluxio-${ALLUXIO_VERSION}-bin.tar.gz" && \
    ln -sv "alluxio-${ALLUXIO_VERSION}" alluxio && \
    cp -v alluxio/conf/alluxio-env.sh.template alluxio/conf/alluxio-env.sh && \
    alluxio format && \
    apk del wget tar

COPY configs/alluxio-site.properties alluxio/conf/
COPY entrypoint.sh /

EXPOSE 19999 30000
