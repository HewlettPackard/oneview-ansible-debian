FROM python:2.7-slim-stretch

LABEL maintainer "Hewlett Packard Enterprise <github@hpe.com>"

WORKDIR /root

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -y \
    && apt-get install --no-install-recommends -y \
    openssh-client curl \
    && apt-get clean \
    && apt-get autoremove -y \
    && pip install pyOpenSSL ansible hpOneView \
    && rm -rf /var/lib/apt/lists/* /tmp/* /root/.cache \
    && curl -SL https://github.com/HewlettPackard/oneview-ansible/archive/v5.1.1.tar.gz | \
    tar xz \
    && mv oneview-ansible-5.1.1 oneview-ansible

ENV ANSIBLE_LIBRARY=/root/oneview-ansible/library
ENV ANSIBLE_MODULE_UTILS=/root/oneview-ansible/library/module_utils/

CMD [ "/usr/local/bin/ansible", "--version" ]
