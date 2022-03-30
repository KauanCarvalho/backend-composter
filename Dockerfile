FROM ruby:3.0.0-alpine

RUN apk add --update --no-cache \
    bash \
    postgresql-dev \
    build-base \
    git \
    tzdata \
    nodejs \
    less

WORKDIR /app

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm \
    BUNDLE_APP_CONFIG=/app/.bundle

COPY Gemfile.lock ./

RUN gem update --system && \
    gem install bundler -v $(tail -1 /app/Gemfile.lock | xargs) --conservative --default && \
    bundle config specific_platform x86_64-linux

CMD tail -f /dev/null
