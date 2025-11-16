FROM arm32v7/debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    vim \
    git \
    python3 \
    python3-pip \
    && apt-get clean

WORKDIR /workspace

CMD ["/bin/bash"]

