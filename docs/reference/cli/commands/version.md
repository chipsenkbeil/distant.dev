Retrieves version information of the remote server.

| Name              | Description                                                               | Example           |
| ----------------- | ------------------------------------------------------------------------- | ----------------- |
| Server Version    | The version of the server                                                 | 0.20.0            |
| Protocol Version  | The version of the protocol (different servers can have same protocol)    | 0.1.0             |
| Capabilities      | What features the server has implemented                                  | "search"          |

{{ run("distant version --help", into_admonition=True) }}
