Reads an entire file pointed to by `path` and returns the file's contents
as bytes.

## Request

```json
{
    "type": "file_read",
    "path": "..."
}
```

### Fields

* `path`: absolute or relative path to the file to read.

## Response

The file's bytes will be returned in a `blob` message.

```json
{
    "type": "blob",
    "data": []
}
```

### Fields

* `data`: contents of the file as a byte array where each element is a single
  byte.
