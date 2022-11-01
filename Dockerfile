FROM ruby:2.6.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /rover
RUN gem install bundler -v 1.17.3

COPY Gemfile /rover/Gemfile
COPY Gemfile.lock ./rover/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
COPY . ./rover/

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
