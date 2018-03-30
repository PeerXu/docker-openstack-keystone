# docker-openstack-keystone
Development environment for Openstack Keystone in Docker container.

## Start Keystone Service

    docker-compose up

## Stop Keystone Service

    docker-compose down

## Manage Keystone via openstack tools

    docker-compose exec keystone sh
    . /root/openrc
    openstack token issue
