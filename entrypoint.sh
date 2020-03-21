#!/usr/bin/env bash

#=========================================================================================
# Variables
#=========================================================================================
CERT_DIR="/etc/letsencrypt/live/${DOMAIN}"
SSL_CERT="${CERT_DIR}/fullchain.pem"
SSL_KEY="${CERT_DIR}/privkey.pem"
DOMAIN="bradleyalanprice.com"
EMAIL="bradley.alan.price@gmail.com"
DO_CREDS="/etc/letsencrypt/digitalocean.ini"
PROPAGATION="60"

#=========================================================================================
# Functions
#=========================================================================================

log() {
    echo -e "$(date "+%b %d %T")" "$(basename "$0")" - "$@" 
}

create_certs() {
  
  log "Creating Certificate for [${DOMAIN}]"

  certbot certonly --dns-digitalocean \
      --dns-digitalocean-credentials "${DO_CREDS}" \
      --dns-digitalocean-propagation-seconds "${PROPAGATION}" \
      --domain "${DOMAIN}" --domain "*.${DOMAIN}" -m "${EMAIL}" \
      --agree-tos --non-interactive
}

renew_certs() {
  while true 
  do 
    certbot renew
    sleep 86400
  done
}

##########################################################################################

if [[ ! -f ${SSL_CERT} ]] || [[ ! -f ${SSL_KEY} ]]; then
    log "SSL Certificates do NOT exist"
    create_certs
fi

renew_certs
