FROM alpine:latest
ARG XMRIG_VERSION=v6.4.0

RUN adduser -S -D -H -h /xmrig miner
RUN apk --no-cache upgrade && \
    apk add --no-cache --repository \
        http://dl-cdn.alpinelinux.org/alpine/edge/testing hwloc-dev && \
    apk --no-cache add \
        git \
        make \
        cmake \
        libstdc++ \
        gcc \
        g++ \
        automake \
        libtool \
        autoconf \
        linux-headers && \
    git clone https://github.com/xmrig/xmrig && \
    cd xmrig && \
    git checkout ${XMRIG_VERSION} && \
    mkdir build && \
    cd scripts && \
    ./build_deps.sh && \
    cd ../build && \
    cmake .. -DXMRIG_DEPS=scripts/deps \
        -DBUILD_STATIC=ON \
        -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc) && \
    apk del \
    cmake \
    git

USER miner
WORKDIR /xmrig/build
ENTRYPOINT ["./xmrig"]
