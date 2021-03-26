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
