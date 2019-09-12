#FROM ubuntu:bionic
FROM ruby:2.3

RUN apt-get update -qq || echo "apt update failed" && apt-get install -y git sqlite ruby ruby-bundler ruby-dev

RUN git clone https://github.com/nov/openid_connect_sample_rp.git

WORKDIR openid_connect_sample_rp
RUN echo 'http://openid.sso-security.de:8080' > public/.professos

# we simply run bundle in dev mode
RUN bundle install && \
  bundle exec rake db:create db:migrate db:seed
  
# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-p", "8080"]
