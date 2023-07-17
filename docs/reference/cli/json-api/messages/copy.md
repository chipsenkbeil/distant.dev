Copies a file or directory designated by `src` to `dst`.

!!! note

    This will automatically copy directories recursively, meaning their entire
    contents will be copied.

## Request

```json
{
    "type": "copy",
    "src": "...",
    "dst": "..."
}
```

### Fields

* `src`: absolute or relative path to be copied.

* `dst`: absolute or relative path where to place the copy.

## Response

```json
{
    "type": "ok"
}
```
