FROM centos:8

LABEL maintainer="https://github.com/dmitryfill"

ENV XO_VERSION ${XO_VERSION:-5.51.0}
# Requires NodeJS v14 or newer
ENV NODE_VERSION ${NODE_VERSION:-14}

ENV XO_PORT ${XO_PORT:-80}


COPY ./ /

RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
  rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg && \
  rpm -ivh https://forensics.cert.org/cert-forensics-tools-release-el8.rpm && \
  dnf module enable nodejs:${NODE_VERSION} -y && \
  dnf install -y epel-release && \
  dnf update -y && \
  dnf --enablerepo=forensics install -y \
    automake \
    cifs-utils \
    gcc \
    gcc-c++ \
    git \
    libpng-devel \
    libvhdi-tools \
    lvm2 \
    make \
    nfs-utils \
    nodejs \
    npm \
    openssl-devel \
    python3 \
    redis \
    yarn && \
  dnf clean all && \
  rm -rf /var/cache/yum && \
  mkdir -p /app/ && \
  systemctl enable redis && \
  git clone --depth 1 --branch master https://github.com/vatesfr/xen-orchestra.git /app/ && \
  cd /app/ && \
  yarn && yarn build && \
  chmod +x /entry-point.sh && \
  chmod +x /health-check.sh

# git clone --depth 1 --branch xo-web-v${XO_VERSION} https://github.com/vatesfr/xen-orchestra.git /app/ && \

HEALTHCHECK --start-period=30s --interval=2s --retries=90 --timeout=10s \
  CMD ["/health-check.sh"]

CMD ["bin/bash", "-c", "/entry-point.sh"]

EXPOSE ${XO_PORT}










