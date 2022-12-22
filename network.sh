#!/bin/bash

# network name
NN=alluxio-security_network

create() {
    docker network create \
        --driver=bridge \
        --subnet=172.22.0.0/14 \
        --gateway=172.22.0.1 \
        $NN
}

remove() {
    docker network rm $NN
}

inspect() {
    docker network inspect $NN
}

case $1 in
create)
    create
    ;;
remove)
    remove
    ;;
inspect)
    inspect
    ;;
*)
    echo "network.sh create|remove|inspect"
    ;;
esac
