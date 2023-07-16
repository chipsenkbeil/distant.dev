Retrieve information about a specific connection.

```sh
distant manager info 1234
```

### Flags

* `--format <FORMAT>`: determines how information is printed. With *json*
  specified, information will be printed in this form:
  
    ```json
    { "id": 1234, "destination": "...", "options": "..." }
    ```
    
### Returned Information

| Name         | Description                                                | Example               |
| ------------ | ---------------------------------------------------------- | --------------------- |
| id           | The numeric id of the connection                           | 1234                  |
| destination  | The destination string used to connect to the destination  | distant://example.com |
| options      | Additional options provided during launch/connect          | "verbose=true"        |

{{ run("distant manager info --help", admonition="info") }}
