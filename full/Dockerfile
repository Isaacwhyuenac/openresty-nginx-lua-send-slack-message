FROM openresty/openresty:1.17.8.2-4-centos

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-env

ENV NGINX_ENV 'prod'

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
