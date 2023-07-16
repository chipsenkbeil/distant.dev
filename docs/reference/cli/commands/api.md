Listen over stdin & stdout to communicate with a distant server using the
[JSON lines API](/reference/cli/json-api/).

```sh
distant api
```

### Flags

* `--timeout <N>`: maximum time (in seconds) to wait for a network request
  before timing out. By default, each request waits indefinitely.

{{ run("distant api --help", admonition="info") }}
