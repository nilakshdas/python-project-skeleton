# Python Project Skeleton

# Setup

This skeleton leverages Docker to setup a minimal build system for a python project.
You will need to install [Docker](https://docs.docker.com/get-docker/)
and [Docker Compose](https://docs.docker.com/compose/install/)
for setting up the minimal build system.

For installing the python dependencies on your host system,
simply add them to the `requirements.txt` file
and run the following command:

```
$ pip install -r requirements.txt
```


# Usage

```
$ bash docker-main.sh help
usage: bash docker-main.sh <command> [<args>]

commands:
  build         Setup the minimal build system in docker
  up            Spin up the project container
  down          Spin down the project container

  cli           Run the project CLI (cli.py) inside the project container
  shell         Run the bash shell inside the project container

  ipython       Run an IPython runtime inside the project container
  jupyterlab    Run a Jupyter Lab server inside the project container
                and host it on port 8888 (defined in the .env file)

  help          Show this message

This script creates docker containers of a minimal build system for running this project.
The project namespace (my-python-project) is defined in the .env file.
```
