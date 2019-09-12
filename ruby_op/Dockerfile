FROM ruby:2.3

RUN apt-get update -qq || echo "apt update failed" && apt-get install -y git sqlite ruby ruby-bundler ruby-dev

RUN git clone https://github.com/nov/openid_connect_sample.git

WORKDIR openid_connect_sample
RUN echo 'http://openid.sso-security.de:8080' > public/.professos

# we simply run bundle (dev mode, do not use in production)
RUN bundle install && \
  bundle exec rake db:create db:migrate db:seed
  
RUN sed -i 's!issuer: http://op.dev!issuer: http://honest-idp.com:8282!' config/connect/id_token/issuer.yml
  
# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-p", "8282"]
