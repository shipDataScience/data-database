# base on latest ruby base image
FROM ruby:latest

# update and install dependencies
RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libpq-dev apt-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-client postgresql-client libpq-dev  libmysqlclient-dev
RUN gem install pg mysql

# setup app folders
RUN mkdir /myapp
WORKDIR /myapp

# copy over Gemfile and install bundle
ADD Gemfile /myapp/Gemfile
RUN bundle install

# copy over remaining app files
ADD . /myapp

# run script
CMD [ "bundle",  "exec", "main.rb" ]
