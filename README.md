# oidc-lab

## Build & Run

```
docker-compose build --build-arg GITHUB_TOKEN=${GITHUB_TOKEN}
docker-compose up professos mitreid-connect
```

## Use proxy

- Configure Browser to use Proxy -> localhost:8080
- Sites could be browsed e.g. http://professos without further host configurations

