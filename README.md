# Puppeteer Docker

Puppeteer docker that works both in amd64 and arm64 architecture which includes dumb-init and wkhtmltopdf.


## Build Docker Image

```bash
make build
```

## Run Docker Image

```bash
make run
```

## example

Check the [example](./example) folder for a working example.

## Notes

Use the following code to launch puppeteer.

```javascript
const browser = await puppeteer.launch({
    headless: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-dev-shm-usage",
    ],
  });
```


# Credit

This docker image is based on the work of [Daniel](https://github.com/nook24) and his [docker-puppeteer](https://github.com/it-novum/puppeteer-docker/blob/development/Dockerfile)