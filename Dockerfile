FROM ruby:3.3.5-slim

RUN apt-get update; \
  apt-get install -y curl; \
  curl -sL https://deb.nodesource.com/setup_18.x | bash -; \
  curl -Ss https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
  apt-get update -qq && \
  apt-get install --no-install-recommends -y build-essential postgresql-client libpq-dev git libvips pkg-config nodejs yarn imagemagick

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
