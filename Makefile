build:
	docker build -t e3rp4y/openstack-keystone .
run:
	docker run -t -i -d --hostname controller -e ADMIN_PASSWORD=1q2w3e4r --name keystone krystism/openstack-keystone
clean:
	docker rm -f keystone
exec:
	docker exec -t -i keystone bash
log:
	docker logs -f keystone
