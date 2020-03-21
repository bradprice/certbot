FROM centos:centos7

RUN yum install -y --setopt=tsflags=nodocs python36 && \
    yum install -y --setopt=tsflags=nodocs python3-pip && \
    yum clean all && \
    rm -rf /var/cache/yum/*

#ENTRYPOINT [ "bash", "/entrypoint.sh" ]
CMD ["/bin/bash"]