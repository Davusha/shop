FROM ruby:2.7.2
RUN apt-get update && apt-get install -y \
      curl \
      build-essential \
      libpq-dev &&\
      curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && apt-get install -y nodejs yarn postgresql-client

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

RUN npm config set unsafe-perm true && npm install -g --force yarn
RUN yarn install

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
