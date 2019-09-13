FROM alpine/git as clone
LABEL maintainer="Iván Mauricio Montilla Figueroa"
WORKDIR /app
RUN mkdir srv && cd srv && \ 
git clone --progress https://github.com/immontilla/simple-web-app.git

FROM maven:alpine as build
WORKDIR /app
COPY --from=clone /app/web/simple-web-app /app/web
COPY servlet-context.xml /app/web/src/main/webapp/WEB-INF/spring/appServlet
RUN cd web && mvn -DskipTests clean install && mv target/simple-web-app.war ../WARs

FROM tomcat:alpine
WORKDIR /app
COPY --from=build /app/WARs /app
RUN apk add --no-cache --update openssl && \
cp *.war /usr/local/tomcat/webapps/ && \
rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/ && \
rm /usr/local/tomcat/webapps/ROOT/* && \
cd /usr/local/tomcat/webapps/ROOT/ && \
wget https://raw.githubusercontent.com/immontilla/docker-mitreid-oidc-server/master/index.html && \
echo "https://openid.sso-security.de" > /usr/local/tomcat/webapps/ROOT/.professos