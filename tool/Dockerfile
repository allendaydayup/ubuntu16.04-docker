FROM siya/ubuntu16.04-vim-ssh
MAINTAINER siya Lai <siya891202@gmail.com> <13661189714@163.com>

ADD Dockerfile /data
RUN apt-get update
RUN apt-get install -y nginx git cron supervisor
RUN apt-get install -y php7.1 php7.1-common php7.1-fpm php7.1-dev && \
    apt-get install -y php7.1-mbstring php7.1-xml php7.1-gd php7.1-exif php7.1-zip php7.1-iconv php7.1-mcrypt  && \
    apt-get install -y php-redis php-mongodb php7.1-pgsql php7.1-mysql && \
    apt-get install -y librabbitmq-dev && \
    apt-get install -y php-amqp && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    apt-get install -y yarn && \
    npm install -g cnpm --registry=https://registry.npm.taobao.org && \
    php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /bin/composer && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    composer global require "fxp/composer-asset-plugin:^1.3.1" -vvv && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://getcaddy.com | bash -s personal

RUN mkdir -p /data/src && cd /data/src && \
    wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz && tar -zxvf go1.12.6.linux-amd64.tar.gz

RUN ln -f /data/src/go/bin/go /usr/local/bin/go && ln -f /data/src/go/bin/gofmt /usr/local/bin/gofmt && ln -f /data/src/go/bin/godoc /usr/local/bin/godoc && \
    export GOROOT=/data/src/go && export GOPATH=/data/src/ && echo "PATH=\$PATH:/usr/local/bin" >> /root/.bashrc && echo "PATH=\$PATH:\$GOROOT/bin" >> /root/.bashrc

RUN echo "php version \c" && php -v && \
    echo "nginx version \c" && nginx -v && \
    echo "supervisor version \c" && /usr/bin/supervisord -v && \
    echo "nodejs version \c" && nodejs -v && \
    echo "npm version \c" && npm -v && \
    echo "cnpm version \c" && cnpm -v && \
    echo "yarn version \c" && yarn -v && \
    echo "composer version \c" && composer --version && \
    echo "php modules \c" && php -m && \
    echo "caddy version" && caddy -version
ENV TZ=Asia/Shanghai