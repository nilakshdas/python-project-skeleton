FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

VOLUME /workspace
EXPOSE $JUPYTERLAB_PORT

# Install system dependencies
RUN apt-get update -y -qq \
    && apt-get install -y \
        build-essential \
        curl \
        tmux \
        wget

# Install Conda
ENV CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
RUN wget --quiet $CONDA_URL -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

ENV PATH=/opt/conda/bin:$PATH

# Install python dependencies
RUN conda config --append channels conda-forge
RUN pip install --upgrade pip \
    && pip install \
        ipython \
        jupyterlab \
    && rm -rf /root/.cache/pip/wheels/*

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt \
    && rm /requirements.txt \
    && rm -rf /root/.cache/pip/wheels/*

WORKDIR /workspace

CMD ["bash", "-c", "while true; do sleep infinity; done"]
