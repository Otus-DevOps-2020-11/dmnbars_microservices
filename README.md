# dmnbars_microservices
dmnbars microservices repository

## Homework Docker 3

### Основное задание
 * создана новая структура приложения
 * Написаны Dockerile'ы для comment, post-py и ui сервисов
 * Собраны 1.0 версии этих образов
 * Улучшен образ ui сервиса за счет использования образа ubuntu вместо ruby
 * Создан и подключен volume для контейнера с mongodb что бы данные не терялись при пересоздании контейнеров
 * Исправлены замечания hadolint для Dockerfile'ов

### Первое задание со *
Команды для запуска контейнеров с другими сетевыми алиасами
```shell
docker run -d --network=reddit --network-alias=second_post_db --network-alias=second_comment_db mongo:latest
docker run -d --network=reddit --network-alias=second_post -e POST_DATABASE_HOST=second_post_db dmnbars/post:1.0
docker run -d --network=reddit --network-alias=second_comment -e COMMENT_DATABASE_HOST=second_comment_db dmnbars/comment:1.0
docker run -d --network=reddit -e POST_SERVICE_HOST=second_post -e COMMENT_SERVICE_HOST=second_comment -p 9292:9292 dmnbars/ui:1.0
```

### Второе задание со *
Образы comment и ui минифицированы за счет использования alpine как базового образа:
 * ui - 55.3MB
 * comment - 52.5MB

## Homework Docker 4

### Основное задание
 * Выполнена практика с работой с разными видами сетевых драйверов
 * Запуск контейнеров в одной сети
 * Запуск контейнеров в разных сетях
 * Написан docker-compose.yml
 * docker-compose.yml запускает контейрены в двух сетях
 * docker-compose.yml параметрезирован для использования env
 * написан docker-compose.override.yml для возможности изменять код приложений + запуск puma в debug режиме

### Базовое имя проекта
 * Базовое имя проекта берется как название директории в которой был запущен docker-compose
 * Базовое имя проекта можно переопределить через env переменную `COMPOSE_PROJECT_NAME`
 * Базовое имя проекта можно переопределить при запуске, через опцию `-p`: `docker-compose -p up`

## Homework Gitlab CI 1
 * Написан конфиг terraform для создания VM для установки Gitlab CI
 * Написан Ansible playbook для установки Docker на эту VM
 * Создан проект в Gitlab
 * Для него написан базовый .gitlab-ci.yml
 * Написан Ansible playbook для запуска и регистрации gitlab runner'а
 * В пайплайны добавлены тесты
 * В пайплайны добавлено создание gtilab окружений (статических и динамических)
 * Настроены ограничения на окружения по тегам
 * Написан Ansible playbook для запуска Gitlab CI на этой VM
 * Настроено оповещение в Slack (#aleksandr_borisov) из Gitlab

## Homework Monitoring 1

Docker hub:
 - [ui](https://hub.docker.com/repository/docker/dmnbars/ui)
 - [comment](https://hub.docker.com/repository/docker/dmnbars/comment)
 - [post](https://hub.docker.com/repository/docker/dmnbars/post)
 - [prometheus](https://hub.docker.com/repository/docker/dmnbars/prometheus)

## Homework Monitoring 2

Docker hub:
 - [alertmanager](https://hub.docker.com/repository/docker/dmnbars/alertmanager)

## Homework Logging 1
 - Установлен `docker-machine-driver-yandex`
 - В `docker-compose-logging.yml` добавлен EFK стек
 - Настроена отдача логов через `fluentd` для `post` и `ui` сервиса
 - Логи визуализированны в `kibana`
 - Написан `json` логов для `service.post`
 - Написан `grok` логов для `service.ui`
 - Написан `grok` для второго формата логов в `service.ui`
 - В `docker-compose-logging.yml` добавлен `zipkin`
 - Настроена отправка трейсов из всех сервисов приложения в `zipkin`
 - Найдена причина из-за которой страница конкретного поста грузилась медленно. В `zipkin` было видно, что `span` `db_find_single_post` выполнятеся ддолго (3 секунды). В коде был найден, где этот `span` и там была найдена строчка `time.sleep(3)`
