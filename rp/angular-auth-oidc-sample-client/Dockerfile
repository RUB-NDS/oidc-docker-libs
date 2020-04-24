FROM node:10.15.0-alpine AS builder
COPY ./app/ ./app
WORKDIR /app
RUN npm i
RUN $(npm bin)/ng build --prod

FROM nginx:1.15.8-alpine
COPY --from=builder /app/dist/angular-auth-oidc-sample-client /usr/share/nginx/html

ARG CONTROLLER_URL
ARG CLIENT_HOST

ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

COPY config/default.conf /etc/nginx/conf.d/default.conf
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/nginx/conf.d/default.conf

RUN echo "https://$CONTROLLER_URL" > /usr/share/nginx/html/.professos
