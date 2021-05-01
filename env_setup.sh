
BR2_EXTERNAL="br_external"
BR2_DL_DIR="$BR2_EXTERNAL/downloads"
TARGET=""
DEFAULT_TARGET="raspberrypi3_ya_p1"

function set_target() {
    if [ $# -ne 1 ]; then
        echo "Usage: set_target TARGET"
        return
    fi

    if [ $1 = "default" ]; then
        TARGET=$DEFAULT_TARGET
        echo "Set default target: $TARGET"
    else
        TARGET=$1
        echo "Set target: $TARGET"
    fi

    BULDROOT_OUTPUT="$BR2_EXTERNAL/output/$TARGET"
    m "${TARGET}_defconfig"
}

function get_target() {
    echo "Target: $TARGET"
}

function find_top() {
    while [ "$PWD" != "/" ]; do
        if [ -f "$BR2_EXTERNAL/env_setup.sh" ]; then
            echo "$PWD"
            return
        fi
        cd ..
    done

    echo "Error: could not find top of the tree"
    return 1
}

function m() {
    local TOP
    TOP="$(find_top)" || return

    if [ -z $TARGET ]; then
        echo "Error: need to set target"
        set_target
        return
    fi

    make \
        BR2_EXTERNAL="$TOP/$BR2_EXTERNAL" \
        BR2_DL_DIR="$TOP/$BR2_DL_DIR" \
        O="$TOP/$BULDROOT_OUTPUT" \
        -C "$TOP/buildroot" \
        -j$(nproc) \
        "$@"
}
