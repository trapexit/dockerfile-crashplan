# CrashPlan via Docker container

## Componenets
* Ubuntu 16.04
* s6-overlay v1.19.1.1
* tigervnc v1.7.0
* novnc 558544364cf0d1f91d18b3a5768db8c8292f7ff6
* jre v1.8.0_72
* CrashPlan v4.8.0

## Features
* Usage of novnc is optional
* Xvnc server and CrashPlan GUI launch when connecting (reduces resource consumption)

## Setup

### Manual

```
$ docker run -d \
    --name="crashplan-${NAME}" \
    --restart=unless-stopped \
    -e NOVNC=true \
    -p 5900:5900 \
    -p 6080:6080 \
    -v /media:/media \
    -v /:/rootfs \
    trapexit/crashplan:1.2
```

Remove `-e NOVNC=true` and `-p 6080:6080` if you don't wish to use `novnc.`

### Script

```
#!/bin/bash

NAME="${1}"
COUNT=$(docker ps -qa --filter "label=app=crashplan" | wc -l)
VNC_PORT=$((5900 + COUNT))
NOVNC_PORT=$((6080 + COUNT))

docker run -d \
    --name="crashplan-${NAME}" \
    --restart=unless-stopped \
    --label=app=crashplan \
    --label="backup=${NAME}" \
    -p ${VNC_PORT}:5900 \
    -p ${NOVNC_PORT}:6080 \
    -v /media:/media \
    -v /:/rootfs \
    trapexit/crashplan:1.2
```

## Usage

### VNC (directly)

* Using whichever VNC client you prefer connect to the `VNC_PORT`

### NOVNC (VNC via web)

* Make sure `-e NOVNC=true` is included when creating the container.
* goto `http://<your-host-ip>:${NOVNC_PORT}/vnc.html?autoconnect=true&resize=scale`
