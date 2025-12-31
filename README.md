## Homebridge KND Dockerfile

This repository contains **Dockerfile** of KNXD

### Base Docker Image

* [node](https://hub.docker.com/_/node/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download: `docker pull tekn0ir/homebridge_knxd`

   (alternatively, you can build an image from Dockerfile: `docker build -t="tekn0ir/homebridge_knxd" github.com/tekn0ir/homebridge_knxd`)


### Usage
Observe that Homebridge requires Avahi or compatible service running on host machine(or in another container).

    docker run -d -p 0.0.0.0:51826:51826 --net=host tekn0ir/homebridge_knxd
