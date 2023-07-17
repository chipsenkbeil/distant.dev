Appends to a file pointed to by `path`.

## Request

```json
{
    "type": "file_append_text",
    "path": "...",
    "text": "..."
}
```

### Fields

* `path`: absolute or relative path to the file to write.
* `text`: UTF-8 compliant text to append to the file.

## Response

```json
{
    "type": "ok"
}
```
