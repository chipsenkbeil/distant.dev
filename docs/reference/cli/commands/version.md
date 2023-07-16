Retrieves version information about the remote server.

```sh
distant version
```

### Flags

* `--format <FORMAT>`: determines how information is printed. With *json*
  specified, information will be printed in this form:
  
    ```json
    {
        "server_version": "0.20.0+distant-local",
        "protocol_version": "0.20.0",
        "capabilities": ["exec","fs_io","fs_perm","fs_search","fs_watch","sys_info"]
    }
    ```
    
    Any error encountered will be captured and printed in this form:
  
    ```json
    { "type": "error", "msg": "..." }
    ```

    !!! note

        All JSON comes in a single line format ending in a newline character.

### Returned Information

| Name              | Description                                                               | Example           |
| ----------------- | ------------------------------------------------------------------------- | ----------------- |
| Server Version    | The version of the server                                                 | 0.20.0            |
| Protocol Version  | The version of the protocol (different servers can have same protocol)    | 0.1.0             |
| Capabilities      | What features the server has implemented                                  | "search"          |

{{ run("distant version --help", admonition="info") }}
