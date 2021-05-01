DOCKER_IMAGE=ya_streams
DOCKER_USER=ya
HOST_SRC=$HOME/work_ssd/ya_streams/src

SCRIPT_PATH="`dirname \"$0\"`"

docker_build() {
    docker build \
        -t $DOCKER_IMAGE \
        -f "$SCRIPT_PATH/Dockerfile" \
        --build-arg UID=$(id -u) \
        --build-arg GID=$(id -g) \
        --build-arg UNAME=$DOCKER_USER \
        .
}

docker_run() {
    docker run \
        -ti --rm \
        -v $HOST_SRC:/home/$DOCKER_USER/src \
        $DOCKER_IMAGE \
        bash
}

case $1 in
    "build" ) docker_build ;;
    "run" ) docker_run ;;
esac