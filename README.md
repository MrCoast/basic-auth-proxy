# Basic Auth Proxy

## Description

A simple nginx-based HTTP proxy server that adds Basic Auth to a proxied resource.

## Environment variables

- `PROXY_PASS` [required] - URL of proxied resource, e.g. http://example.com:8888
- `AUTH_BASIC_TITLE` [optional] - Basic realm message passed in `WWW-Authenticate` header.
- `HTPASSWD_USERNAME` [optional] - Basic Auth username. It's **required** if `.htpasswd` file is not mounted.
- `HTPASSWD_PASSWORD` [optional] - Basic Auth password. It's **required** if `.htpasswd` file is not mounted.

## Mount volumes

- `/.htpasswd` [optional] - `.htpasswd` file to use for Basic Auth. If it isn't mounted, it will be generated using `HTPASSWD_USERNAME` and `HTPASSWD_PASSWORD` environment variables.

## Usage

```
docker run --rm -it -p <host port>:80 \
    -e "PROXY_PASS=http://example.com:8888" \
    -e "HTPASSWD_USERNAME=user" \
    -e "HTPASSWD_PASSWORD=secret" \
    <basic-auth-proxy-image>
```

## Testing

Uses [Google Container Structure Test](https://github.com/GoogleContainerTools/container-structure-test) for automated image testing.

```
docker run -i --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${PWD}/tests.yaml:/tests.yaml:ro zemanlx/container-structure-test:v1.9.1-alpine \
    test \
    --image <basic-auth-proxy-image> \
    --config /tests.yaml
```

Add `--pull` if you want to test a non-local image, this will force [Google Container Structure Test](https://github.com/GoogleContainerTools/container-structure-test) to pull the image before running tests.
