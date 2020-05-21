FROM node:13-alpine3.10 AS builder

ENV PATH /opt/oidc-lab/node_modules/.bin:$PATH

COPY app/package.json /opt/oidc-lab/
WORKDIR /opt/oidc-lab
RUN npm install
RUN npm install -g @angular/cli@9.1.5

COPY app /opt/oidc-lab

RUN ng build --prod

## Main image
FROM nginx:1.17.10-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder  /opt/oidc-lab/dist/oidc-lab /usr/share/nginx/html

ARG CLIENT_HOST

ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

COPY config/default.conf /etc/nginx/conf.d/default.conf
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
