FROM hypriot/rpi-alpine-scratch

MAINTAINER Leanne Northrop <lavender.flowerdew@gmail.com>>

LABEL Description="This image is used as base image for my explorations of running JAVA/Node applications on a Raspberry Pi 2 cluster." Version="0.1"

# Download and install glibc
RUN apk update && \
  apk upgrade && \
  apk add bash wget ca-certificates && \
  wget https://github.com/leannenorthrop/alpine-pkg-glibc/releases/download/glibc-2.22-r1-armhf-beta/glibc-2.22-r1.apk && \
  wget https://github.com/leannenorthrop/alpine-pkg-glibc/releases/download/glibc-2.22-r1-armhf-beta/glibc-bin-2.22-r1.apk && \
  wget https://github.com/leannenorthrop/alpine-pkg-glibc/releases/download/glibc-2.22-r1-armhf-beta/libgcc_s.so && \
  wget https://github.com/leannenorthrop/alpine-pkg-glibc/releases/download/glibc-2.22-r1-armhf-beta/libgcc_s.so.1 && \
  apk add --allow-untrusted glibc-2.22-r1.apk && \
  apk add --allow-untrusted glibc-bin-2.22-r1.apk && \
  mv libgcc* /lib && \
  chmod a+x /lib/libgcc_s.so* && \
  cp /usr/glibc-compat/lib/ld-linux-armhf.so.3 /lib && \
  /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
  echo "" > /etc/nsswitch.conf && \ 
  echo "hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4" >> /etc/nsswitch.conf && \
  rm -f glibc-*.apk && \
  apk del wget ca-certificates && \
  rm -rf /var/cache/apk/* 

# Define default command.
CMD ["bash"]
