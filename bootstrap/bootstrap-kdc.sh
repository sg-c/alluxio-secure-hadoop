#!/bin/bash

set -e

# add realms and domain_realm to an independent krb5.conf for sharing
: ${KDC_ADDRESS:=$(hostname -f)}
: ${KERB_ADMIN_PORT:=749}
: ${KERB_KDC_PORT:=88}

cat>/etc/krb5.conf.d/krb5.${REALM}.conf<<EOF
[realms]
   $REALM = {
      kdc = $KDC_ADDRESS:$KERB_KDC_PORT
      admin_server = $KDC_ADDRESS:$KERB_ADMIN_PORT
    }
[domain_realm]
  .$DOMAIN_REALM = $REALM
   $DOMAIN_REALM = $REALM
EOF

# execute the default entrypoint first
/config.sh