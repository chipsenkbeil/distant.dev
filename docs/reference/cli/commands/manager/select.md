Changes the active connection used by other commands when talking to a manager.

```sh
distant manager select 1234
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
    
### Interactive Mode

If no connection id is provided, this command enters an interactive mode, where
it provides a collection of choices and the user identifies which connection to
make the active one.

#### JSON Format

When using `format` as *json*, interactive mode will print out available
choices, the current selection (as a base-0 index), and a `type` field as a
JSON object:

```json
{
    "type": "select",
    "choices": ["distant://example.com:51658", "ssh://example.com"],
    "current": 0
}
```

In response to the available choices, a JSON message needs to be sent in this
form:

```json
{
    "type": "selected",
    "choice": 1
}
```

The `type` field is required while the `choice` field is optional. The `choice`
corresponds to the index of the choice within the `choices` field received
earlier. If none is provided, the current selection is not changed.

!!! note

    All JSON comes in a single line format ending in a newline character.
    Responses are also expected to be sent as a single line containing all JSON
    and ending in a newline character.
    
{{ run("distant manager select --help", admonition="info") }}
