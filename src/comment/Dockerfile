FROM alpine:3.6

RUN apk --no-cache --update add ruby ruby-json ruby-dev build-base \
    && gem install bundler:1.17.2 bson:4.3.0 bson_ext:1.5.1 puma:3.12.0 -N \
    && apk del build-base ruby-dev

ENV APP_HOME /app
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
