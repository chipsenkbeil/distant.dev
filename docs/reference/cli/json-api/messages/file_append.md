Appends to a file pointed to by `path`.

## Request

```json
{
    "type": "file_append",
    "path": "...",
    "data": []
}
```

### Fields

* `path`: absolute or relative path to the file to write.
* `data`: byte array representing the contents to append.

## Response

```json
{
    "type": "ok"
}
```
