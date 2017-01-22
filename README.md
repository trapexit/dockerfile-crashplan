# CrashPlan via Docker container

* Ubuntu 16.04
* s6-overlay v1.19.1.1
* tigervnc v1.7.0
* novnc 558544364cf0d1f91d18b3a5768db8c8292f7ff6
* jre v1.8.0_72
* CrashPlan v4.8.0

## Usage

```
$ docker run -d \
    --name="crashplan-${NAME}" \
    --restart=unless-stopped \
    -e NOVNC=true \
    -p 5900:5900 \
    -p 6080:6080 \
    -v /media:/media \
    -v /:/rootfs \
    trapexit/crashplan:1.1
```

Remove `-e NOVNC=true` and `-p 6080:6080` if you don't wish to use `novnc.`

## Script

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
    trapexit/crashplan:1.1
```
