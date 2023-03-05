ARG DOCKER_IMAGE=archlinux:base-devel
FROM $DOCKER_IMAGE

ARG VERSION="1.0.0"
ENV VERSION=$VERSION

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Bensuperpc <bensuperpc@gmail.com>"
LABEL author="Bensuperpc <bensuperpc@gmail.com>"
LABEL description="A distccd image"

LABEL org.label-schema.schema-version="1.0" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="bensuperpc/distcc" \
  org.label-schema.description="distcc" \
  org.label-schema.version=$VERSION \
  org.label-schema.vendor="bensuperpc" \
  org.label-schema.url="" \
  org.label-schema.vcs-url="https://github.com/bensuperpc/docker-distcc" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.docker.cmd="docker build -t bensuperpc/distcc -f Dockerfile ."

ENV LANG=en_US.utf8

RUN pacman-key --init && pacman -Sy archlinux-keyring --noconfirm && pacman -Syu --noconfirm && \
  pacman -S --noconfirm \
  clang \
  ccache \
  base-devel \
  distcc \
  bash \
  && pacman -Scc --noconfirm

ENTRYPOINT [ \
  "distccd", \
  "--daemon", \
  "--no-detach", \
  "--user", "distcc", \
  "--port", "3632", \
  "--stats", \
  "--stats-port", "3633", \
  "--log-level", "info", \
  "--log-stderr", \
  "--listen", "0.0.0.0" \
  ]

CMD [\
  "--allow", "0.0.0.0/0", \
  "--nice", "4", \
]

EXPOSE 3632/tcp 3633/tcp

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://0.0.0.0:3633/ || exit 1
