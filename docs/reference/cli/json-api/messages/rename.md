Renames a file or directory designated by `src` to `dst`.

## Request

```json
{
    "type": "rename",
    "src": "...",
    "dst": "..."
}
```

### Fields

* `src`: absolute or relative path to be renamed.

* `dst`: absolute or relative path acting as the destination of the rename.

## Response

```json
{
    "type": "ok"
}
```
