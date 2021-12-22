FROM lsiobase/ubuntu:bionic

RUN apt-get update -yq && \
    apt-get -yq --no-install-recommends install software-properties-common python3 python3-pip python3-setuptools && \
    add-apt-repository ppa:isc/bind && \
    apt-get update -yq && \
    apt-get -yq --no-install-recommends -o Dpkg::Options::=--force-confdef install bind9 && \
    python3 -m pip install  --upgrade pip && \
    python3 -m pip install  jinja2-cli && \
    apt-get clean && \
    rm /etc/bind/rndc.key && \
    rm /etc/bind/named.conf.options && \ 
    rm /etc/bind/named.conf.default-zones && \
    rm /etc/bind/named.conf.local && \ 
    rm /etc/bind/zones.rfc1918 && \ 
    rm /etc/bind/db*

COPY root/ /

EXPOSE 5353

