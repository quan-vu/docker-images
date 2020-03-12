FROM ubuntu:18.04

LABEL MAINTAINER Quan Vu "info@quanvu.net"

ENV REFRESHED_AT 2020-02-20

LABEL io.k8s.description="Ubuntu VNC Container with Xfce window manager, firefox and chromium" \
      io.k8s.display-name="Ubuntu VNC Container based on Ubuntu" \
      io.openshift.expose-services="6901:http,5901:xvnc" \
      io.openshift.tags="vnc, ubuntu, xfce" \
      io.openshift.non-scalable=true

## Connection ports for controlling the UI:
# VNC port:5901
ENV DISPLAY=:1
ENV VNC_PORT=5901 
EXPOSE $VNC_PORT 

# noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV NO_VNC_PORT=6901
EXPOSE $NO_VNC_PORT

### Envrionment config
ENV HOME=/ubuntu \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/ubuntu/install \
    NO_VNC_HOME=/ubuntu/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=800x600 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false
WORKDIR $HOME

### Add all install scripts for further steps
ADD ./src/common/install/ $INST_SCRIPTS/
ADD ./src/install/ $INST_SCRIPTS/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

### Install some common tools
RUN $INST_SCRIPTS/tools.sh
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

### Install custom fonts
RUN $INST_SCRIPTS/install_custom_fonts.sh

### Install xvnc-server
RUN $INST_SCRIPTS/tigervnc.sh

### Install noVNC - HTML5 based VNC viewer
RUN $INST_SCRIPTS/no_vnc.sh

### Install firefox and chrome browser
RUN $INST_SCRIPTS/firefox.sh
RUN $INST_SCRIPTS/chrome.sh

### Install xfce UI
RUN $INST_SCRIPTS/xfce_ui.sh
ADD ./src/common/xfce/ $HOME/

### configure startup
RUN $INST_SCRIPTS/libnss_wrapper.sh
ADD ./src/common/scripts $STARTUPDIR
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

USER 1000

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]
