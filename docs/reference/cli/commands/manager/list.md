List information about all connections.

```sh
distant manager list
```

### Flags

* `--format <FORMAT>`: determines how information is printed. With *json*
  specified, information will be printed in this form:
  
    ```json
    { "<ID>": "<DESTINATION>" }
    ```
    
    where `<ID>` is the connection's numeric id, but used as a string key in
    *json* and `<DESTINATION>` is the destination string used to launch/connect
    to the server.
    
    Any error encountered will be captured and printed in this form:
  
    ```json
    { "type": "error", "msg": "..." }
    ```

    !!! note

        All JSON comes in a single line format ending in a newline character.
    
### Returned Information

For each connection, its id and destination are printed:

| Name         | Description                                          | Example               |
| ------------ | -----------------------------------------------------| --------------------- |
| id           | The numeric id of the connection                     | 1234                  |
| destination  | The destination string used to connect to the server | distant://example.com |

{{ run("distant manager list --help", admonition="info") }}
