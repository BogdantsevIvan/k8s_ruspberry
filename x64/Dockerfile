FROM ubuntu:focal
COPY ./1.3.3 /tmp
WORKDIR /tmp
RUN chmod +x /tmp/install.sh
RUN /bin/bash -c "./install.sh --enable-log --i386-dep"
RUN /bin/bash -c "apt install libicu-dev -y"
CMD /etc/init.d/mplc4 start  && sleep infinity
EXPOSE 80
EXPOSE 30550