FROM python:3

RUN apt-get update -qq && apt-get install -y git vim less tcpdump

RUN git clone https://github.com/openid/JWTConnect-Python-OidcRP.git

###
# CherryPy RP (fails on webfinger w/ "Response is not subscriptable")
#
WORKDIR JWTConnect-Python-OidcRP/chrp/

COPY conf/conf.py ./conf.py

RUN ./make_opbyuid_html.py conf > html/opbyuid.html

RUN pip3 install cherrypy cryptojwt oidcrp PyYaml
RUN pip3 install flask

EXPOSE 8089 8090

# allow redirects
RUN sed -i 's|self.request_args = {"allow_redirects": False}|self.request_args = {"allow_redirects": True}|' ../src/oidcrp/http.py


COPY ./conf/professos_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

CMD ["./rp.py", "-k", "conf"]

###
# flask_rp (fails on webfinger)
#

#WORKDIR /JWTConnect-Python-OidcRP/flask_rp/

#sed -i 's!^BASEURL = "https://localhost:{}".format(PORT)!BASEURL = "https://honest-sp.com:{}".format(PORT)!' fc_conf.py

#RUN sed -i 's!^BASEURL = "https://127.0.0.1:{}".format(PORT)!BASEURL = "https://honest-sp.com:{}".format(PORT)!' bc_conf.py

#RUN sed -i "s|app.run(host='127.0.0.1', port=app.config.get('PORT'),|app.run(host=\'0.0.0.0\', port=app.config.get(\'PORT\'),|" wsgi.py

#COPY ./conf/professos_ca.crt /usr/local/share/ca-certificates/
#RUN update-ca-certificates

#EXPOSE 8089 8090

#CMD "./run.sh"

#
### /flask_rp
