FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential vim python3 python3-pip git curl

# install pipx
RUN python3 -m pip install --user pipx

# add pipx to the path
ENV PATH=/root/.local/bin:$PATH

# install pipx deps
RUN apt-get install -y python3-venv

# install ansible
RUN pipx install --include-deps ansible

COPY local.yml /root/local.yml
COPY tasks /root/tasks

CMD []
