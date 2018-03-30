mkdir -p /var/lib/keystone

keystone-manage db_sync
keystone-manage fernet_setup --keystone-user root --keystone-group root

uwsgi --http 0.0.0.0:35357 --wsgi-file $(which keystone-wsgi-admin) &
uwsgi --http 0.0.0.0:5000 --wsgi-file $(which keystone-wsgi-public) &

keystone-manage bootstrap --bootstrap-username admin \
		--bootstrap-password 'admin123!@#' \
		--bootstrap-project-name admin \
		--bootstrap-role-name admin \
		--bootstrap-service-name keystone \
		--bootstrap-admin-url "http://localhost:35357/v3" \
		--bootstrap-public-url "http://localhost:5000/v3" \
		--bootstrap-internal-url "http://localhost:5000/v3"
