FROM freeradius/freeradius-server:latest

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends gettext-base mariadb-client \
  && rm -rf /var/lib/apt/lists/*

COPY deploy/freeradius/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY deploy/freeradius/templates/clients.conf.template /opt/radius/templates/clients.conf.template
COPY deploy/freeradius/templates/mods-enabled-sql.template /opt/radius/templates/mods-enabled-sql.template
COPY deploy/freeradius/templates/sites-enabled-default.template /opt/radius/templates/sites-enabled-default.template
COPY deploy/freeradius/templates/sites-enabled-inner-tunnel.template /opt/radius/templates/sites-enabled-inner-tunnel.template

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
