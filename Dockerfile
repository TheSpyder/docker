# A docker image to build the jekyll docker image.
FROM envygeeks/alpine
MAINTAINER Andrew Herron <thespyder@programmer.net>
ENV \
  LANGUAGE=en_US \
  LANG=en_US.UTF-8 \
  LC_ALL=en_US
RUN \
  apk --update add zlib-dev build-base libxml2-dev libxslt-dev readline-dev \
    libffi-dev ruby-dev yaml-dev zlib-dev libxslt-dev readline-dev libxml2-dev \
    libffi-dev ruby-dev yaml-dev zlib libxml2 build-base ruby-io-console readline \
    libxslt ruby yaml libffi nodejs ruby-irb ruby-json ruby-rake ruby-rdoc \
    git && \

  yes | gem update --no-document -- --use-system-libraries && \
  yes | gem update --system --no-document -- --use-system-libraries && \

  gem clean && gem install bundler \
    --no-document

ADD Gemfile Gemfile.lock /tmp/
RUN cd /tmp && bundle install

WORKDIR /build
VOLUME  /build