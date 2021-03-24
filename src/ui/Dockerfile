FROM alpine:3.6

RUN apk --no-cache --update add ruby=2.4.6-r0 ruby-json=2.4.6-r0 ruby-dev=2.4.6-r0 build-base=0.5-r0 \
    && gem install bundler:1.17.2 bson_ext:1.12.5 thrift:0.9.3.0 puma:3.12.0 -N \
    && apk del build-base ruby-dev

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install
COPY . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
