#! /usr/bin/env sh

uwsgi --http 0.0.0.0:35357 --wsgi-file $(which keystone-wsgi-admin) &
uwsgi --http 0.0.0.0:5000 --wsgi-file $(which keystone-wsgi-public)
