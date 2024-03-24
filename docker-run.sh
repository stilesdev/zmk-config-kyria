#!/usr/bin/env bash

WORKDIR="/workspaces/zmk/app"

case "$1" in
    init)
        git clone https://github.com/zmkfirmware/zmk.git ./volumes/zmk || exit $?
        WORKDIR="/workspaces/zmk"
        COMMAND="west init -l app/ && west update"
        ;;
    build)
        COMMAND="west build -p -d build/left -b nice_nano_v2 -- -DSHIELD='kyria_rev3_left nice_view_adapter nice_view' -DZMK_CONFIG='/workspaces/zmk-config/config' && west build -p -d build/right -b nice_nano_v2 -- -DSHIELD='kyria_rev3_right nice_view_adapter nice_view' -DZMK_CONFIG='/workspaces/zmk-config/config' && cp build/left/zephyr/zmk.uf2 /workspaces/build/kyria_rev3_left.uf2 && cp build/right/zephyr/zmk.uf2 /workspaces/build/kyria_rev3_right.uf2"
        ;;
    rebuild)
        COMMAND="west build -d build/left && west build -d build/right && cp build/left/zephyr/zmk.uf2 /workspaces/build/kyria_rev3_left.uf2 && cp build/right/zephyr/zmk.uf2 /workspaces/build/kyria_rev3_right.uf2"
        ;;
    shell)
        COMMAND="bash"
        ;;

    *)
        echo "Usage: $0 {init|build|rebuild|shell}"
        exit 1
esac
    
docker run \
-v ./volumes/zmk:/workspaces/zmk \
-v ./volumes/home:/root \
-v ./volumes/build:/workspaces/build \
-v ./zmk-config:/workspaces/zmk-config \
-w "$WORKDIR" \
--rm \
-it \
docker.io/zmkfirmware/zmk-dev-arm:3.2 \
bash -c "source /root/.bashrc && $COMMAND"
