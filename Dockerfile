FROM ruby:3.1.4-alpine as assets
LABEL maintainer="Edward Heaver <edward.heaver01@gmail.com>"

RUN mkdir /project
WORKDIR /project

# Set UID and GID for least priv
ARG UID=1000
ARG GID=1000

RUN apk update && apk add bash
RUN apk update \
    && apk add --no-cache build-base curl git postgresql-dev nodejs npm \
    && npm install -g corepack \
    && addgroup -g "${GID}" ruby \
    && adduser -D -u "${UID}" -G ruby ruby \
    && mkdir /node_modules && chown ruby:ruby -R /node_modules /app \
    && rm -rf /var/cache/apk/*

USER ruby
COPY --chown=ruby:ruby Gemfile* ./
RUN bundle install

COPY --chown=ruby:ruby package.json *yarn* ./
RUN yarn install

ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    NODE_ENV="${NODE_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin:/node_modules/.bin" \
    USER="ruby"

COPY --chown=ruby:ruby . .

RUN if [ "${RAILS_ENV}" != "development" ]; then \
  SECRET_KEY_BASE_DUMMY=1 rails assets:precompile; fi

CMD ["bash"]
