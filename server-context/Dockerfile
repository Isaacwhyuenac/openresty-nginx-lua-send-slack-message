FROM openresty/openresty:1.17.8.2-4-centos

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http

COPY ./nginx.conf /etc/nginx/conf.d/default.conf