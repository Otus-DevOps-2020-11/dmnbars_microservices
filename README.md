# dmnbars_microservices
dmnbars microservices repository

## Homework Docker 3

### Первое задание со *
Команды для запуска контейнеров с другими сетевыми алиасами
```shell
docker run -d --network=reddit --network-alias=second_post_db --network-alias=second_comment_db mongo:latest
docker run -d --network=reddit --network-alias=second_post -e POST_DATABASE_HOST=second_post_db dmnbars/post:1.0
docker run -d --network=reddit --network-alias=second_comment -e COMMENT_DATABASE_HOST=second_comment_db dmnbars/comment:1.0
docker run -d --network=reddit -e POST_SERVICE_HOST=second_post -e COMMENT_SERVICE_HOST=second_comment -p 9292:9292 dmnbars/ui:1.0
```
