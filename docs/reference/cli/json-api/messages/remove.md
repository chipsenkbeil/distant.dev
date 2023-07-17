Removes a file or directory designated by `path`.

## Request

```json
{
    "type": "remove",
    "path": "...",
    "force": false
}
```

### Fields

* `path`: absolute or relative path to remove.

* `force`: (optional, default: `false`) whether or not to remove non-empty
  directories. If a directory is not empty and this is false, then the request
  will fail.

## Response

```json
{
    "type": "ok"
}
```
