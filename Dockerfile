FROM ruby:2.5

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs

COPY Gemfile* /usr/src/ruby-bank/
WORKDIR /usr/src/ruby-bank/

RUN gem install bundler -v 2.0.2

RUN gem install rubygems-update
RUN update_rubygems
RUN gem update --system

RUN bundle _2.0.2_ install

COPY . /usr/src/ruby-bank

CMD ["rails", "s", "-b", "0.0.0.0"]
