FROM debian:latest

LABEL maintainer="askldfhjg@gmail.com"
USER root

RUN apt-get update && apt-get install -y curl wget gnupg vim
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn locales git nodejs npm libx11-dev libxkbfile-dev libsecret-1-dev pkg-config && rm -rf /var/lib/apt/lists/* && localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
RUN nodejs -v

WORKDIR /root
RUN git clone https://github.com/microsoft/vscode.git
WORKDIR /root/vscode
RUN git checkout master
RUN git pull https://github.com/microsoft/vscode.git master
RUN yarn
CMD yarn web