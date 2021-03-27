.PHONY: default build build_comment build_post build_ui build_mongodb_exporter build_prometheus push push_comment push_post push_ui push_mongodb_exporter push_prometheus

UI_VERSION ?= latest
COMMENT_VERSION ?= latest
POST_VERSION ?= latest
MONGODB_EXPORTER_VERSION ?= latest
PROMETHEUS_VERSION ?= latest

default: build

build_comment:
	docker build -t $(USER_NAME)/comment:$(COMMENT_VERSION) -f ./src/comment/Dockerfile ./src/comment

build_post:
	docker build -t $(USER_NAME)/post:$(POST_VERSION) -f ./src/post-py/Dockerfile ./src/post-py

build_ui:
	docker build -t $(USER_NAME)/ui:$(UI_VERSION) -f ./src/ui/Dockerfile ./src/ui

build_mongodb_exporter:
	docker build -t $(USER_NAME)/mongodb_exporter:$(MONGODB_EXPORTER_VERSION) -f ./monitoring/mongodb_exporter/Dockerfile ./monitoring/mongodb_exporter

build_prometheus:
	docker build -t $(USER_NAME)/prometheus:$(PROMETHEUS_VERSION) -f ./monitoring/prometheus/Dockerfile ./monitoring/prometheus

build: build_comment build_post build_ui build_mongodb_exporter build_prometheus

push_comment:
	docker push dmnbars/comment:$(COMMENT_VERSION)

push_post:
	docker push dmnbars/post:$(POST_VERSION)

push_ui:
	docker push dmnbars/ui:$(UI_VERSION)

push_mongodb_exporter:
	docker push dmnbars/mongodb_exporter:$(MONGODB_EXPORTER_VERSION)

push_prometheus:
	docker push dmnbars/prometheus:$(PROMETHEUS_VERSION)

push: push_comment push_post push_ui push_mongodb_exporter push_prometheus
