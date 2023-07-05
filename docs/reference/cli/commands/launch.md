Connects to a remote machine through some method, starts a `distant`
server, and then connects to that server. The connection used to first
access the machine is closed.

```sh
distant launch ssh://example.com
```

In the above example, the following happens:

1. An ssh connection is established with `example.com`
2. A distant server is spawned via `distant server listen --daemon`
3. The port and authentication key are sent back to the client over ssh
4. The ssh connection is closed
5. The client attempts to connect to `example.com` over TCP using the provided
   port and authenticates using the provided key

{{ run("distant launch --help", admonition="info") }}
