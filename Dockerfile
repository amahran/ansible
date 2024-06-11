## first build
FROM ubuntu:noble AS base
# Switch work dir, so that all subsequent commands are ran from there
WORKDIR /usr/local/bin
# Suppress interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages, including sudo
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    curl \
    git \
    sudo \
    ansible \
    # Clears out the apt cache to reduce the image size
    && rm -rf /var/lib/apt/lists/*

## second build
FROM base AS prof
ARG TAGS

# Add a new user and give sudo access without a password
RUN addgroup --gid 1009 elprofessor && \
    adduser --gecos elprofessor --uid 1009 --gid 1009 --disabled-password elprofessor

# Ensure elprofessor can use sudo without a password
RUN echo 'elprofessor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER elprofessor
ENV USER=elprofessor
WORKDIR /home/elprofessor
COPY --chown=elprofessor:elprofessor . ./ansible

CMD ["sh", "-c", "ansible-playbook $TAGS ansible/local.yml"]
