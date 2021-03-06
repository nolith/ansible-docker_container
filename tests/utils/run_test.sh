#!/bin/sh -e

IMAGE_FULL=${IMAGE}:${VERSION}
docker stop ansible >/dev/null 2>&1 || true
docker rm ansible >/dev/null 2>&1 || true
docker pull ${IMAGE_FULL}
docker run --privileged -d --name ansible -v `pwd`:/data ${IMAGE_FULL}
docker exec -it ansible /bin/sh -c "ansible-playbook /data/tests/test.yml -i /data/tests/inventory --syntax-check"
docker exec -it ansible /bin/sh -c "ansible-playbook -v /data/tests/test.yml -i /data/tests/inventory -c local"
