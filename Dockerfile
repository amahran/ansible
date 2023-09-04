FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential vim git curl

COPY install /root/install
COPY local.yml /root/local.yml
COPY tasks /root/tasks

CMD ["sh", "-c", "./root/install"]
