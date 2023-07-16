Kills a connection, removing it from the manager's list and severing the actual
connection with the remote server.

```sh
distant manager kill 1234
```

### Flags

* `--format <FORMAT>`: determines how the response is printed. With *json*
  specified, the response will be printed in this form:
  
    ```json
    { "type": "ok" }
    ```
    
    Any error encountered will be captured and printed in this form:
  
    ```json
    { "type": "error", "msg": "..." }
    ```

    !!! note

        All JSON comes in a single line format ending in a newline character.
    
{{ run("distant manager kill --help", admonition="info") }}
