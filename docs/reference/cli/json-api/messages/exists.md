Checks if the `path` exists.

## Request

```json
{
    "type": "exists",
    "path": "..."
}
```

### Fields

* `path`: absolute or relative path to check.

## Response

The result will be returned in an `exists` message.

```json
{
    "type": "exists",
    "value": false
}
```

### Fields

* `value`: will be `true` if the path exists, otherwise `false`.
