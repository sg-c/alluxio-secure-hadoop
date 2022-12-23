#!/bin/bash

set -e

echo "bootstrap 111"

# execute the default entrypoint first
/config.sh

echo "bootstrap 222"

# /shared/krb5 is mounted by a named volume 
# and shared by services in the same compose app
echo "includedir /etc/krb5.conf.d" > /shared/krb5/krb5.conf
cat /etc/krb5.conf >> /shared/krb5/krb5.conf

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

echo "bootstrap 333"