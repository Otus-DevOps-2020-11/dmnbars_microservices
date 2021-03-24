FROM alpine:3.6
RUN apk update \
    && apk add ruby ruby-json ruby-dev build-base \
    && gem install bundler:1.17.2 -N

ENV APP_HOME /app

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
