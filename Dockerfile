FROM ruby:2.6.3
RUN useradd -u 1000 local

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN sh -c "curl -sL https://deb.nodesource.com/setup_lts.x | bash -"
RUN apt install -y npm
RUN npm install -g yarn@1.22.1

RUN mkdir /myapp
WORKDIR /myapp
