

# OpenResty Slack

This repo demonstrates how to send slack messages through [nginx](https://www.nginx.com/) if a webhook (eg. from [git-sync](https://github.com/kubernetes/git-sync)) is received.
To achieve this, [OpenResty](https://github.com/openresty/openresty), a nginx distribution with lua at its heart, is used.

## Tech Stack
- [OpenResty](https://openresty.org/en/getting-started.html)
- [OpenResty Docker](https://github.com/openresty/docker-openresty)
- [Lua](https://github.com/lua/lua)
- [Slack](https://api.slack.com/docs/messages/builder?msg=%7B%22attachments%22%3A%5B%7B%22fields%22%3A%5B%7B%22value%22%3A%22Applied%20dags%20change%20to%20cluster%20https%3A%2F%2Fgithub.com%2Fhk01-digital%2Fdata-airflow-dags%22%2C%22title%22%3A%22Airflow%20Dags%20updated%22%7D%2C%7B%22value%22%3A%220e2f83a5784ba508fae638ebd32e1c555303511a%22%2C%22title%22%3A%22Commit%22%7D%5D%2C%22title%22%3A%22Airflow%20Dags%20git-sync%22%2C%22color%22%3A%22danger%22%2C%22mrkdwn_in%22%3A%5B%22text%22%5D%7D%5D%7D)

- [Leafo - Full Documentation of how to install and manage Lua package through Luarocks](https://leafo.net/guides/customizing-the-luarocks-tree.html)
- [Great YouTube Channel to learn more about Lua](https://www.youtube.com/user/bob100487/videos)

## Nginx
For nginx configuration, you can put different form of configurations files on different locations dependent on your use cases.

- If you only need the `server` context directives, you can put the config files inside the `/etc/nginx/conf.d/<anyname>.conf`
- If you need a ground-up change on nginx config, you have to create a brand-new nginx.conf file on `/usr/local/openresty/nginx/conf/nginx.conf`(may vary on different linux distro).

## Commands
To build the OpenResty docker image on DEBUG mode on stdout

```zsh
  docker build . -t nginx-test --build-arg RESTY_RPM_FLAVOR="-debug"
  docker run --rm --name mycontainer -p 8000:80 nginx-test
```


## Full Nginx conf
If you need to update your full nginx conf, you can look at [full folder](./full/)

## Server Context Nginx conf
if you need to add just a portion of nginx conf (eg. the server context), you can look at [server-context](./server-context/)
