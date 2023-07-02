FROM ubuntu:latest

ENV HOME=/home/user/
WORKDIR $HOME

RUN apt-get update && apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt-get -y install libgtk-3-bin git libgccjit-11-dev libjansson-dev build-essential autoconf texinfo libsqlite3-dev libgtk-3-dev libgnutls28-dev libncurses-dev apt-utils libtree-sitter-dev libxml2 texlive-full dvipng ripgrep 

RUN sudo apt-get -y install xorg libgtk-3-dev libx11 libxpm4

RUN git clone https://www.github.com/emacs-mirror/emacs --depth=1
WORKDIR $HOME/emacs
RUN ./autogen.sh 
RUN ./configure --with-json --with-xpm=ifavailable --with-gif=ifavailable --with-native-compilation --with-pgtk --with-jpeg --with-png --with-rsvg --with-tiff --with-wide-int --with-xft --with-xml2 --with-mailutils --with-xpm CFLAGS="-O3 -march=native"
RUN make -j$(nproc)
RUN make install
WORKDIR $HOME
RUN rm -rf emacs

