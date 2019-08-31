FROM irssi:latest
MAINTAINER hymnis <hymnis@plazed.net>

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
