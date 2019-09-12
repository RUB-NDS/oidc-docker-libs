FROM python:3

RUN apt-get update -qq && apt-get install -y git vim less tcpdump

#RUN git clone https://github.com/rohe/pyoidc.git
# use the version hosted under OpenIDC
RUN git clone https://github.com/OpenIDC/pyoidc.git

WORKDIR pyoidc

# use bugfix release from 31.01.2019
RUN git checkout tags/v0.15.1

RUN python setup.py install && \
    pip3 install -r oidc_example/simple_op/requirements.txt && \
    pip3 install -r oidc_example/simple_rp/requirements.txt

WORKDIR oidc_example/

# fix serving JWK set (now included in below fix file)
#RUN mkdir static && \
#    sed -i -e 's!#provider.jwks_uri.append(!provider.jwks_uri = "{}/static/{}".format(provider.baseurl, name)!' src/provider/server/server.py

# fixed server.py version:
# - enables basic auth (header must be passed to tokenEndpoint)
# - fixes JWKS URI
COPY conf/simple_op_fixed-server.py simple_op/src/provider/server/server.py

COPY conf/simple_rp-settings.yaml simple_rp/settings.yaml.example
COPY conf/run.sh ./run_op_rp.sh

EXPOSE 8000 8880

#CMD ["python", "src/run.py", "settings.yaml.example", "-p", "8000", "-b", "http://honest-idp.com:8000"]
CMD "./run_op_rp.sh"
