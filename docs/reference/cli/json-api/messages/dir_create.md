Creates a directory designated by `path`.

## Request

```json
{
    "type": "dir_create",
    "path": "...",
    "all": false
}
```

### Fields

* `path`: absolute or relative path to the directory to create.

* `all`: (optional, default: `false`) whether or not to create all missing,
  intermediate directories.

## Response

```json
{
    "type": "ok"
}
```
