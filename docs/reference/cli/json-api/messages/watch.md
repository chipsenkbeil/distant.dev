Watches a `path` for changes and reports them as they occur.

## Request

```json
{
    "type": "watch",
    "path": "...",
    "recursive": false,
    "only": [],
    "except": []
}
```

### Fields

* `path`: absolute or relative path to watch.

* `recursive`: (optional, default: `false`) if true, will recursively watch for
  changes within directories, otherwise will only watch for changes immediately
  within directories.

* `only`: (optional, default: `[]`) limits reported events to only those
  specified. If empty, will not limit events. Each value is one of the change
  kinds possible (see response for types).

* `except`: (optional, default: `[]`) limits reported events to all but those
  specified. If empty, will not limit events. Each value is one of the change
  kinds possible (see response for types).

## Response

The immediate response will be a success:

```json
{
    "type": "ok"
}
```

### Change event

As events are detected, each will be sent back in this format:

```json
{
    "type": "change",
    "timestamp": 1234,
    "kind": "...",
    "path": "...",
    "details": {
        "attribute": "...",
        "renamed": "...",
        "timestamp": 1234,
        "extra": "..."
    }
}
```

#### Fields

* `timestamp`: the Unix timestamp in seconds for when the event occurred.

* `kind`: the kind of change detected. Can be one of these types:

    * `access`: a file was read.
    * `attribute`: a file's or directory's attributes were changed.
    * `closeWrite`: a file open for writing was closed.
    * `closeNoWrite`: a file not open for writing was closed.
    * `create`: a file, directory, or something else was created within a watched directory.
    * `delete`: a file, directory, or something else was deleted.
    * `modify`: a file's content was modified.
    * `open`: a file was opened.
    * `rename`: a file, directory, or something else was renamed in some way.
    * `unknown`: catch-all for any other change.
    
* `path`: the path to the file or directory that changed.

* `details`: (optional, default: `undefined`) object containing extra
  information dependent on the change.

    * `attribute`: (optional, default: `undefined`) can be `ownership`,
      `permissions`, or `timestamp` and indicates what attribute was changed.
    * `renamed`: (optional, default: `undefined`) is the new path when some
      path is renamed. In other words, what the path was renamed to.
    * `timestamp`: (optional, default: `undefined`) is the timestamp of the
      file or directory referenced by `path`. This is populated when `modify`
      is detected.
    * `extra`: (optional, default: `undefined`) platform-specific information.
