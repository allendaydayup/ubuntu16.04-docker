FROM       ubuntu:16.04
MAINTAINER siya Lai <siya891202@gmail.com> <13661189714@163.com>

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install openssh-server vim libncurses5-dev && \
    apt-get -y install ncurses-dev libreadline6-dev lua5.1-0-dev ruby ruby-dev python-dev && \
    apt-get -y install libyaml-cpp-dev zlib1g.dev && \
    apt-get -y install gcc git curl tzdata && \
    apt-get -y install language-pack-zh-hant-base language-pack-zh-hans-base
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN echo "set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1" >> ~/.vimrc && \
    echo "set termencoding=utf-8" >> ~/.vimrc && \
    echo "set fileformats=unix" >> ~/.vimrc && \
    echo "set encoding=prc" >> ~/.vimrc

RUN echo "alias vi=vim" >> ~/.bashrc
RUN mkdir -p ~/.vim/bundle/vim-go ~/.vim/bundle/Vundle.vim
ADD vim-go/ /root/.vim/bundle/vim-go
ADD Vundle.vim/ /root/.vim/bundle/Vundle.vim
WORKDIR /data
ADD Dockerfile /data

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

