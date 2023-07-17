Writes to a file pointed to by `path`, overwriting it if it exists.

## Request

```json
{
    "type": "file_write_text",
    "path": "...",
    "text": "..."
}
```

### Fields

* `path`: absolute or relative path to the file to write.
* `text`: UTF-8 compliant text to use as the file's contents.

## Response

```json
{
    "type": "ok"
}
```
