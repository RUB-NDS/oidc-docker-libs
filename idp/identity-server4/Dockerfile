FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS builder

ARG BRANCH="3.1.2"

WORKDIR /checkout
RUN git clone --branch $BRANCH https://github.com/IdentityServer/IdentityServer4.git .

WORKDIR /app
RUN mv /checkout/samples/Quickstarts/3_AspNetCoreAndApis/src/IdentityServer/* .
COPY config/Startup.cs .

# Build package
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

RUN apt-get update && apt-get install -y \
    apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

ARG CONTROLLER_URL
ARG SERVER_HOST
# Activate to serve homepage
ENV ASPNETCORE_ENVIRONMENT="Development"
# Start
ENV ASPNETCORE_URLS="http://localhost:8080"

COPY --from=builder /app/out .

RUN echo "https://$CONTROLLER_URL" > /var/www/static_professos
###
# deploy certs
ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

###
# apache
COPY config/server.conf /etc/apache2/sites-available/
RUN sed -i "s#SERVER_HOST#$SERVER_HOST#g" /etc/apache2/sites-available/server.conf
RUN a2enmod rewrite proxy_http headers ssl
RUN a2dissite 000-default
RUN a2ensite server

EXPOSE 80
EXPOSE 443

#ENTRYPOINT ["dotnet", "IdentityServer.dll"]
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
