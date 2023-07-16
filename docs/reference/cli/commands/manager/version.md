Retrieves version information about the manager.

```sh
distant manager version
```

### Flags

* `--format <FORMAT>`: determines how information is printed. With *json*
  specified, information will be printed in this form:
  
    ```json
    { "version": "0.20.0" }
    ```
    
    Any error encountered will be captured and printed in this form:
  
    ```json
    { "type": "error", "msg": "..." }
    ```

    !!! note

        All JSON comes in a single line format ending in a newline character.

### Returned Information

| Name    | Description                | Example |
| ------- | -------------------------- | ------- |
| Version | The version of the manager | 0.20.0  |

{{ run("distant manager version --help", admonition="info") }}
