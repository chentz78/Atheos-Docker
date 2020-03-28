#!/bin/sh

# Install Atheos if not already installed.
if [ ! -d '/code/.git' ]; then
    cp -r /default-code/. /code
    chmod go+w \
        /code/config.php \
        /code/workspace \
        /code/plugins \
        /code/themes \
        /code/data
fi

# Set user:group ID.
ATHEOS_UID=${ATHEOS_UID:-2743}
ATHEOS_GID=${ATHEOS_GID:-2743}

if [ ! "$(id -u john)" -eq "$ATHEOS_UID" ]; then
    usermod -o -u "$ATHEOS_UID" john
fi
if [ ! "$(id -g john)" -eq "$ATHEOS_GID" ]; then
    groupmod -o -g "$ATHEOS_GID" john
fi

exec "$@"
