FROM dtzar/helm-kubectl:2.14.2

ENV DOCTL_VERSION=1.23.1

RUN helm init --client-only \
  && helm plugin install https://github.com/rimusz/helm-tiller

WORKDIR /tmp

RUN apk add --no-cache curl \
  && curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
  && mv /tmp/eksctl /usr/local/bin \
  && curl --silent -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x ./aws-iam-authenticator \
  && mv ./aws-iam-authenticator /usr/local/bin

ENTRYPOINT ["bash"]