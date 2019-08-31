#!/bin/bash

SSH_CONF=$HOME/.ssh
KEYS_FILE=$SSH_CONF/authorized_keys
AUTHORIZED_KEYS_PREFIX="command=\"$AUTHORIZED_KEYS_CMD\",$AUTHORIZED_KEYS_OPTS"

service ssh start

if [ -n "$AUTHORIZED_KEYS" ]; then
  mkdir -p "$SSH_CONF"
  chmod 700 "$SSH_CONF"
  touch "$KEYS_FILE"
  chmod 600 "$KEYS_FILE"

  IFS=$'\n'

  for key in $(echo "${AUTHORIZED_KEYS}" | tr "," "\n"); do
    key="$AUTHORIZED_KEYS_PREFIX $(echo "$key" | sed -e 's/^ *//' -e 's/ *$//')"
    echo "Adding public key to .ssh/authorized_keys: $key"
    echo "$key" >> "$KEYS_FILE"
  done
else
  (>&2 echo "ERROR: No AUTHORIZED_KEYS specified")
  exit 1
fi

echo "Setting user permissions"
chown user:user -R "$HOME"

echo "Starting irssi in screen session ($SCREEN_NAME) $*"
export TERM='linux'
su user -c "script -q -c 'screen -S $SCREEN_NAME -d -m irssi $*' /dev/null"

