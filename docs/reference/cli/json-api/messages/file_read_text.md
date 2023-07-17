Reads an entire file pointed to by `path` and returns the file's contents
as UTF-8 text. Will fail if the file cannot be represented as UTF-8 text.

## Request

```json
{
    "type": "file_read_text",
    "path": "..."
}
```

### Fields

* `path`: absolute or relative path to the file to read.

## Response

The file's bytes will be returned in a `text` message.

```json
{
    "type": "text",
    "data": "..."
}
```

### Fields

* `data`: contents of the file as UTF-8 text.
