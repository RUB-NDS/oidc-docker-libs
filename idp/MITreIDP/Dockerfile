FROM alpine/git as clone
WORKDIR /app
RUN mkdir srv && cd srv && \ 
git clone --progress https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server.git

FROM maven:alpine as build
WORKDIR /app
COPY --from=clone /app/srv/OpenID-Connect-Java-Spring-Server /app/srv
COPY server-config.xml /app/srv/src/main/webapp/WEB-INF
RUN cd srv && mvn -Dmaven.javadoc.skip=true -DskipTests clean install && \
mkdir ../WARs && mv openid-connect-server-webapp/target/openid-connect-server-webapp.war ../WARs

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
#ADD servlet-context.xml /usr/local/tomcat/webapps/simple-web-app/WEB-INF/spring/appServlet/