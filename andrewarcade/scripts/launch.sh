#!/bin/bash

APP_DIR="/andrewarcade/cabinets/test-app"
BINARY="./build/flappyTurd.x86_64"

# Runtime directory
mkdir -p /run/user/1001
chown arcade:arcade /run/user/1001
chmod 700 /run/user/1001

# seatd socket
if [ -S /run/seatd.sock ]; then
    chown root:seat /run/seatd.sock
    chmod 770 /run/seatd.sock
fi

cd "$APP_DIR"

runuser -u arcade -- env \
    XDG_RUNTIME_DIR=/run/user/1001 \
    WLR_BACKEND=drm \
    WLR_RENDERER=gles2 \
    /usr/bin/cage -d -s -- box64 "$BINARY"
