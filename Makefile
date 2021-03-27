.PHONY: default build build_comment build_post build_ui build_mongodb_exporter build_prometheus push push_comment push_post push_ui push_mongodb_exporter push_prometheus start_app restart_app down_app start_monitoring restart_monitoring down_monitoring build_alertmanager

default: build

build_comment:
	hadolint src/comment/Dockerfile
	cd src/comment && bash docker_build.sh

build_post:
	hadolint src/post-py/Dockerfile
	cd src/post-py && bash docker_build.sh

build_ui:
	hadolint src/ui/Dockerfile
	cd src/ui && bash docker_build.sh

build_mongodb_exporter:
	hadolint monitoring/mongodb_exporter/Dockerfile
	docker build -t $(USER_NAME)/mongodb_exporter -f ./monitoring/mongodb_exporter/Dockerfile ./monitoring/mongodb_exporter

build_prometheus:
	hadolint monitoring/prometheus/Dockerfile
	docker build -t $(USER_NAME)/prometheus -f ./monitoring/prometheus/Dockerfile ./monitoring/prometheus

build_alertmanager:
	hadolint monitoring/alertmanager/Dockerfile
	docker build -t $(USER_NAME)/alertmanager -f ./monitoring/alertmanager/Dockerfile ./monitoring/alertmanager

build: build_comment build_post build_ui build_mongodb_exporter build_prometheus build_alertmanager

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

start_app:
	cd docker && docker-compose up -d

restart_app: down_app start_app

down_app:
	cd docker && docker-compose down

start_monitoring:
	cd docker && docker-compose -f docker-compose-monitoring.yml up -d

restart_monitoring: down_monitoring start_monitoring

down_monitoring:
	cd docker && docker-compose -f docker-compose-monitoring.yml down
