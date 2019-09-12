FROM microsoft/dotnet:2.2-sdk

# is overridden by launchSettings.json
#ENV ASPNETCORE_URLS=http://*:5000,http://*:5001,http://*:5002

RUN apt-get update -qq && apt-get install -y vim curl git less
RUN mkdir -p /opt/is4/src/

WORKDIR /opt/is4/src
# install templates
RUN dotnet new -i IdentityServer4.Templates && \
# choose our base template
  dotnet new is4inmem 

COPY ./conf/appsettings.json .
COPY ./conf/Startup.cs .

# dont restrict to loopback interface
RUN sed -i 's!localhost!0.0.0.0!g' ./Properties/launchSettings.json

EXPOSE 5000 5001 5002

ENTRYPOINT [ "dotnet", "run" ]
