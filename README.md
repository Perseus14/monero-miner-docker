![Monero Minning](https://raw.githubusercontent.com/giansalex/monero-miner-docker/master/assets/monero-mining-docker-coin.png)

# Monero Miner on Docker Alpine
[![Docker Build Status](https://img.shields.io/docker/cloud/build/giansalex/monero-miner.svg)](https://hub.docker.com/r/giansalex/monero-miner/) ![Docker downloads](https://img.shields.io/docker/pulls/giansalex/monero-miner.svg?label=downloads) ![Image size](https://img.shields.io/docker/image-size/giansalex/monero-miner)

Image of latest [XMRig](https://github.com/xmrig/xmrig) version, built on Alpine.

## Run

For easy start, with default configuration.

```sh
docker build -t miner .
docker run --name monero_miner miner```

