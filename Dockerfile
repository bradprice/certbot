FROM centos:centos7

RUN yum install -y --setopt=tsflags=nodocs python36 && \
    yum install -y --setopt=tsflags=nodocs python3-pip && \
    pip3 install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir certbot certbot-dns-digitalocean && \
    yum clean all && \
    rm -rf /var/cache/yum/*

#ENTRYPOINT [ "bash", "/entrypoint.sh" ]
CMD ["/bin/bash"]