.PHONY: default build build_comment build_post build_ui build_mongodb_exporter build_prometheus push push_comment push_post push_ui push_mongodb_exporter push_prometheus start_app restart_app down_app start_monitoring restart_monitoring down_monitoring build_alertmanager build_telegraf push_telegraf build_grafana push_grafana

COMMENT_VERSION ?= latest
POST_VERSION ?= latest
UI_VERSION ?= latest

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

build_telegraf:
	hadolint monitoring/telegraf/Dockerfile
	docker build -t $(USER_NAME)/telegraf -f ./monitoring/telegraf/Dockerfile ./monitoring/telegraf

build_grafana:
	hadolint monitoring/grafana/Dockerfile
	docker build -t $(USER_NAME)/grafana -f ./monitoring/grafana/Dockerfile ./monitoring/grafana

build: build_comment build_post build_ui build_mongodb_exporter build_prometheus build_alertmanager build_telegraf build_grafana

push_comment:
	docker push dmnbars/comment:$(COMMENT_VERSION)

push_post:
	docker push dmnbars/post:$(POST_VERSION)

push_ui:
	docker push dmnbars/ui:$(UI_VERSION)

push_mongodb_exporter:
	docker push dmnbars/mongodb_exporter

push_prometheus:
	docker push dmnbars/prometheus

push_alertmanager:
	docker push dmnbars/alertmanager

push_telegraf:
	docker push dmnbars/telegraf

push_grafana:
	docker push dmnbars/grafana

push: push_comment push_post push_ui push_mongodb_exporter push_prometheus push_alertmanager push_telegraf push_grafana

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
