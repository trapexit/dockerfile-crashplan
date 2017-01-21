FROM trapexit/s6-ubuntu:1.18.1.5-16.04
ADD files /tmp
RUN /tmp/setup/install
ENTRYPOINT ["/init"]
EXPOSE 5900 6080

