FROM python:2.7-alpine
MAINTAINER PeerXu "pppeerxu@gmail.com"

ENV VERSION=13.0.0

RUN set -x \
    && apk update \
    && apk add git gcc make libffi-dev python-dev openssl-dev libsasl libldap linux-headers mariadb-dev musl-dev


RUN git clone https://github.com/openstack/keystone.git \
    && cd keystone \
    && git checkout ${VERSION} \
    && pip install -e . \
    && pip install uwsgi MySQL-python \
    && cp -r etc /etc/keystone \
    && mv /etc/keystone/policy.v3cloudsample.json /etc/keystone/policy.json \
    && pip install python-openstackclient \
    && pip install pika==0.10

COPY keystone.conf /etc/keystone/keystone.conf
COPY openrc /root/openrc

# Add bootstrap script and make it executable
COPY bootstrap.sh /root/bootstrap.sh
RUN chown root:root /root/bootstrap.sh \
    && chmod a+x /root/bootstrap.sh \
    && /bin/sh /root/bootstrap.sh

COPY startup.sh /root/startup.sh
RUN chown root:root /root/startup.sh \
    && chmod a+x /root/startup.sh
ENTRYPOINT ["/bin/sh", "/root/startup.sh"]
EXPOSE 5000 35357

HEALTHCHECK --interval=10s --timeout=5s \
  CMD curl -f http://localhost:5000/v3 2> /dev/null || exit 1; \
  curl -f http://localhost:35357/v3 2> /dev/null || exit 1; \
