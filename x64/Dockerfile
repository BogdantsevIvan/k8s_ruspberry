FROM ubuntu:20.04

COPY 1.3.3 /tmp/
COPY start.sh /tmp

RUN chmod +x /tmp/install.sh /tmp/start.sh 
WORKDIR /tmp
RUN /bin/bash /tmp/install.sh --i386-dep

# CMD [ "/bin/bash", "/etc/init.d/mplc4", " start" ]
ENTRYPOINT [ "/bin/bash", "/tmp/start.sh"]
# CMD ["/etc/init.d/mplc4", "start"]