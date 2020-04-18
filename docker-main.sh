#!/usr/bin/env bash

set -a && . .env && set +a

declare -r SCRIPT_CONTEXT="$PROJECT_NAME/docker-main"
declare -r PROJECT_HOST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd -P)"

log() {
    echo "[$SCRIPT_CONTEXT] $@"
}

help() {
    echo "usage: bash docker-main.sh <command> [<args>]"
    echo
    echo "commands:"
    echo "  build         Setup the minimal build system in docker"
    echo "  up            Spin up the project container"
    echo "  down          Spin down the project container"
    echo
    echo "  cli           Run the project CLI (cli.py) project container"
    echo "  shell         Run the bash shell inside the project container"
    echo
    echo "  ipython       Run an IPython runtime inside the project container"
    echo "  jupyterlab    Run a Jupyter Lab server inside the project container"
    echo "                and host it on port $JUPYTERLAB_PORT (defined in the .env file)"
    echo
    echo "  help          Show this message"
    echo
    echo "This script creates docker containers of a minimal build system for running this project."
    echo "The project namespace ($PROJECT_NAME) is defined in the .env file."
}

build() {
    log "Building docker image..." \
        && docker-compose build $@
}

up() {
    build -q \
        && log "Spinning up / reconnecting to project container..." \
        && docker-compose up --remove-orphans -d $@
}

down() {
    up \
        && log "Spinning down project container..." \
        && docker-compose down
}

cli() {
    up \
        && log "Running project CLI..." \
        && docker-compose exec project python cli.py $@
}

shell() {
    up \
        && log "Starting shell..." \
        && docker-compose exec project bash
}

ipython() {
    up \
        && log "Starting IPython runtime..." \
        && docker-compose exec project ipython
}

jupyterlab() {
    up \
        && log "Starting Jupyter Lab..." \
        && docker-compose exec project jupyter lab \
            --port=$(JUPYTERLAB_PORT) \
            --ip=0.0.0.0 \
            --no-browser \
            --allow-root
}

if [[ -z $1 ]]; then
    help
fi

CMD=$1
ARGS=${@:2}
$CMD $ARGS
