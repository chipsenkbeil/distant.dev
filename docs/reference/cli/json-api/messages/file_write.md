Writes to a file pointed to by `path`, overwriting it if it exists.

## Request

```json
{
    "type": "file_write",
    "path": "...",
    "data": []
}
```

### Fields

* `path`: absolute or relative path to the file to write.
* `data`: byte array representing the file's contents.

## Response

```json
{
    "type": "ok"
}
```
