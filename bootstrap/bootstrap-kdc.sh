#!/bin/bash

# /tmp/etc/krb5.conf is mounted by a named volume 
# and shared by services in the same compose app
echo "includedir /etc/krb5.conf.d" > /tmp/etc/krb5.conf
cat /etc/krb5.conf >> /tmp/etc/krb5.conf

# add realms and domain_realm to an independent krb5.conf for sharing
cat>/etc/krb5.conf.d/krb5.${REALM}.conf<EOF
[realms]
   $REALM = {
      kdc = $KDC_ADDRESS:$KERB_KDC_PORT
      admin_server = $KDC_ADDRESS:$KERB_ADMIN_PORT
    }
[domain_realm]
  .$DOMAIN_REALM = $REALM
   $DOMAIN_REALM = $REALM
EOF