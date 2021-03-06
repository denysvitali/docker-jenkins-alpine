FROM jenkins/jenkins:2.132-alpine

USER root

RUN apk -U add docker
# Setup Jenkins
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN apk add --update shadow \
    && groupadd -g 50 staff \
    && usermod -a -G staff jenkins && usermod -a -G docker jenkins
RUN apk add python3\ 
    rust\ 
    python\ 
    py2-pip\ 
    python3-dev\ 
    python2-dev\ 
    python-dev\ 
    libffi\ 
    libffi-dev\ 
    build-base\ 
    python-dev\ 
    py-pip\ 
    jpeg-dev\ 
    zlib-dev\ 
    cairo-dev\ 
    wget\ 
    ca-certificates\
    git

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    apk --no-cache -X http://apkproxy.herokuapp.com/sgerrand/alpine-pkg-glibc add glibc glibc-bin
USER root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "bash", "/usr/local/bin/entrypoint.sh" ]
