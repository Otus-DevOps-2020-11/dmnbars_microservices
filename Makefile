.PHONY: default build build_comment build_post build_ui build_mongodb_exporter build_prometheus push push_comment push_post push_ui push_mongodb_exporter push_prometheus

default: build

build_comment:
	cd src/comment && bash docker_build.sh

build_post:
	cd src/post-py && bash docker_build.sh

build_ui:
	cd src/ui && bash docker_build.sh

build_mongodb_exporter:
	docker build -t $(USER_NAME)/mongodb_exporter -f ./monitoring/mongodb_exporter/Dockerfile ./monitoring/mongodb_exporter

build_prometheus:
	docker build -t $(USER_NAME)/prometheus -f ./monitoring/prometheus/Dockerfile ./monitoring/prometheus

build: build_comment build_post build_ui build_mongodb_exporter build_prometheus

push_comment:
	docker push dmnbars/comment

push_post:
	docker push dmnbars/post

push_ui:
	docker push dmnbars/ui

push_mongodb_exporter:
	docker push dmnbars/mongodb_exporter

push_prometheus:
	docker push dmnbars/prometheus

push: push_comment push_post push_ui push_mongodb_exporter push_prometheus
