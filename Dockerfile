FROM python:3.7-slim-buster

LABEL maintainer "Hewlett Packard Enterprise <github@hpe.com>"

WORKDIR /root

ENV ONEVIEW_ANSIBLE_VERSION=5.3.1

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -y \
    && apt-get install --no-install-recommends -y \
    openssh-client curl \
    && apt-get clean \
    && apt-get autoremove -y \
    && pip install pyOpenSSL ansible hpOneView==5.0.0b0 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /root/.cache \
    && curl -SL https://github.com/HewlettPackard/oneview-ansible/archive/v${ONEVIEW_ANSIBLE_VERSION}.tar.gz | \
    tar xz \
    && mv oneview-ansible-${ONEVIEW_ANSIBLE_VERSION} oneview-ansible

ENV ANSIBLE_LIBRARY=/root/oneview-ansible/library
ENV ANSIBLE_MODULE_UTILS=/root/oneview-ansible/library/module_utils/

CMD [ "/usr/local/bin/ansible", "--version" ]
