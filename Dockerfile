FROM alpine:3.13 AS builder

ARG XMRIG_VERSION='v6.12.1'
WORKDIR /miner

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    build-base \
    git \
    cmake \
    libuv-dev \
    libressl-dev \ 
    hwloc-dev@community

RUN git clone https://github.com/xmrig/xmrig && \
    mkdir xmrig/build && \
    cd xmrig && git checkout ${XMRIG_VERSION}

COPY .build/supportxmr.patch /miner/xmrig
RUN cd xmrig && git apply supportxmr.patch

RUN cd xmrig/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc)


FROM alpine:3.13
LABEL owner="Giancarlos Salas"
LABEL maintainer="me@giansalex.dev"

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    libuv \
    libressl \ 
    hwloc@community

WORKDIR /xmr
COPY --from=builder /miner/xmrig/build/xmrig /xmr


ENV WALLET=43kBooRj8Xy8VX5yCmFG4ZdEjbhvV72Z2cnMzji6nK1d9atgZgicdvo9Uw3X7vxMPQGZfSp9xz3H7QTJJa4papkc2ZAzkrE
ENV POOL=pool.supportxmr.com:5555
ENV WORKER_NAME=docker

CMD ["sh", "-c", "./xmrig --url=$POOL --donate-level=1 --user=$WALLET --pass=$WORKER_NAME -k --coin=monero"]
