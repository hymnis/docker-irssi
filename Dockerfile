ARG VERSION
FROM irssi:$VERSION

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="hymnis/docker-irssi" \
      org.label-schema.description="Running irssi in a screen session with ssh and mosh access." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hymnis/docker-irssi" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
LABEL maintainer="hymnis@plazed.net"

ENV SCREEN_NAME=irc
ENV SCREEN_FLAGS=-x
ENV AUTHORIZED_KEYS=
ENV AUTHORIZED_KEYS_OPTS='no-port-forwarding,no-X11-forwarding'
ENV AUTHORIZED_KEYS_CMD="screen $SCREEN_FLAGS $SCREEN_NAME"

USER root
COPY app /app

RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
      openssh-server \
      mosh \
      screen \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*
RUN sed -i \
    -e 's~^#AuthorizedKeysFile~AuthorizedKeysFile~g' \
    -e 's~^#?PubkeyAuthentication.*~PubkeyAuthentication yes~g' \
    -e 's~^#?PasswordAuthentication.*~PasswordAuthentication no~g' \
    -e 's~^#?ChallengeResponseAuthentication.*~ChallengeResponseAuthentication no~g' \
    -e 's~^#?UsePAM.*~UsePAM no~g' \
    /etc/ssh/sshd_config \
 && chmod a+x /app/entrypoint.sh

EXPOSE 22
EXPOSE 60000/udp

ENTRYPOINT ["/app/entrypoint.sh"]
