#!/bin/sh
set -eu

config_root="/etc/freeradius/3.0"
template_root="/opt/radius/templates"

: "${RADIUS_DB_HOST:?RADIUS_DB_HOST is required}"
: "${RADIUS_DB_PORT:?RADIUS_DB_PORT is required}"
: "${RADIUS_DB_NAME:?RADIUS_DB_NAME is required}"
: "${RADIUS_DB_USER:?RADIUS_DB_USER is required}"
: "${RADIUS_DB_PASSWORD:?RADIUS_DB_PASSWORD is required}"
: "${RADIUS_SHARED_SECRET:?RADIUS_SHARED_SECRET is required}"
: "${RADIUS_CLIENT_IPADDR:?RADIUS_CLIENT_IPADDR is required}"
: "${RADIUS_CLIENT_NAME:?RADIUS_CLIENT_NAME is required}"
: "${RADIUS_CLIENT_SHORTNAME:?RADIUS_CLIENT_SHORTNAME is required}"

until mariadb-admin ping \
  --host="${RADIUS_DB_HOST}" \
  --port="${RADIUS_DB_PORT}" \
  --user="${RADIUS_DB_USER}" \
  "--password=${RADIUS_DB_PASSWORD}" \
  --silent; do
  sleep 2
done

envsubst < "${template_root}/clients.conf.template" > "${config_root}/clients.conf"
envsubst < "${template_root}/mods-enabled-sql.template" > "${config_root}/mods-enabled/sql"
envsubst < "${template_root}/sites-enabled-default.template" > "${config_root}/sites-enabled/default"
envsubst < "${template_root}/sites-enabled-inner-tunnel.template" > "${config_root}/sites-enabled/inner-tunnel"

exec freeradius -f
