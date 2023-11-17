FROM ruby:3.1.4-alpine as assets
LABEL maintainer="Edward Heaver <edward.heaver01@gmail.com>"

RUN mkdir /project
WORKDIR /project

# Set UID and GID for least priv
ARG UID=1000
ARG GID=1000

RUN apk update && apk add bash
RUN apk update \
    && apk add --no-cache build-base curl git postgresql-dev nodejs npm tzdata \
    && npm install -g corepack \
    && addgroup -g "${GID}" ruby \
    && adduser -D -u "${UID}" -G ruby ruby \
    && mkdir /node_modules && chown ruby:ruby -R /node_modules /project \
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

#############################################################################################

FROM ruby:3.1.4-alpine AS app
LABEL maintainer="Edward Heaver <edward.heaver01@gmail.com>"

WORKDIR /app

ARG UID=1000
ARG GID=1000

RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata vips imagemagick \
    && addgroup -g "${GID}" ruby \
    && adduser -D -u "${UID}" -G ruby ruby \
    && chown ruby:ruby -R /app

USER ruby
COPY --chown=ruby:ruby bin/ ./bin
RUN chmod 0755 bin/*

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

COPY --chown=ruby:ruby --from=assets /usr/local/bundle /usr/local/bundle
COPY --chown=ruby:ruby --from=assets /app/public /public
COPY --chown=ruby:ruby . .

ENTRYPOINT ["/app/bin/entrypoint"]

EXPOSE 3000

CMD ["rails", "s"]
