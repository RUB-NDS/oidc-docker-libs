FROM mcr.microsoft.com/dotnet/core/sdk:3.1.100 AS builder

ARG BRANCH="3.1.2"

WORKDIR /checkout
RUN git clone --branch $BRANCH https://github.com/IdentityServer/IdentityServer4.git .

WORKDIR /app

RUN mv /checkout/samples/Quickstarts/3_AspNetCoreAndApis/src/IdentityServer/* .
RUN dotnet restore

RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app

# Activate to serve homepage
#ENV ASPNETCORE_ENVIRONMENT="Development"

COPY --from=builder /app/out .
EXPOSE 80
#EXPOSE 443

ENTRYPOINT ["dotnet", "IdentityServer.dll"]
