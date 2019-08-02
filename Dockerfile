FROM dtzar/helm-kubectl:2.14.2

ENV DOCTL_VERSION=1.23.1

RUN helm init --client-only \
  && helm plugin install https://github.com/rimusz/helm-tiller

WORKDIR /tmp

RUN apk add --no-cache curl \
  && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
  && curl -L https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz  | tar xz \
  && mv doctl /usr/local/bin
#   && doctl kubernetes cluster kubeconfig save ${CLUSTER_NAME}

ENTRYPOINT ["bash"]