# youtube-dl-server

Very spartan Web and REST interface for downloading youtube videos onto a server. [`bottle`](https://github.com/bottlepy/bottle) + [`youtube-dl`](https://github.com/rg3/youtube-dl).

![screenshot][1]

## Running

### Docker CLI

This example uses the docker run command to create the container to run the app. Here we also use host networking for simplicity. Also note the `-v` argument. This directory will be used to output the resulting videos.

#### example
Enabled **port forwarding(80 - 8080)**, **volume mount(download dir)**, *keep `/usr` directory* in this case.
```shell
docker run -d -p 80:8080 --name youtube-dl --mount type=bind,src=<download directory>,dst=/youtube-dl -v v1:/usr ycrack/youtube-dl-webui
```

Same for PowerShell.

## Usage

### Start a download remotely

Downloads can be triggered by supplying the `{{url}}` of the requested video through the Web UI or through the REST interface via curl, etc.

#### HTML

Just navigate to `http://{{host}}/youtube-dl` and enter the requested `{{url}}`.

#### Curl

```shell
curl -X POST --data-urlencode "url={{url}}" http://{{address}}/youtube-dl/q
```

## Implementation

The server uses [`bottle`](https://github.com/bottlepy/bottle) for the web framework and [`youtube-dl`](https://github.com/rg3/youtube-dl) to handle the downloading. The integration with youtube-dl makes use of their [python api](https://github.com/rg3/youtube-dl#embedding-youtube-dl).

This docker image is based on [`python:slim`](https://registry.hub.docker.com/_/python/) and consequently [`debian:stretch-slim`](https://hub.docker.com/_/debian/).

[1]:youtube-dl-server.png

---

## Changes from the original

1. Omit waste code and addjusted in README.md.
2. Rewrite it to appropriate command in README.md.
3. Add code for install PhantomJS to Dockerfile. (because it is used for several sites, in youtube-dl.)