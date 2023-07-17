Reads the contents of a directory designated by `path`, returning the entries.

## Request

```json
{
    "type": "dir_read",
    "path": "...",
    "depth": 1,
    "absolute": false,
    "canonicalize": false,
    "include_root": false
}
```

### Fields

* `path`: absolute or relative path to the directory to read.

* `depth`: (optional, default: `1`) maximum depth to traverse with 0 indicating
  there is no maximum depth and 1 indicating the most immediate children within
  the directory.

* `absolute`: (optional, default: `false`) whether or not to return absolute or
  relative paths.
 
* `canonicalize`: (optional, default: `false`) whether or not to canonicalize
  the resulting paths, meaning returning the canonical, absolute form of a path
  with all intermediate components normalized and symbolic links resolved.

    !!! note

        The flag absolute must be true to have absolute paths returned, even if
        canonicalize is flagged as true.

* `include_root`: (optional, default: `false`) whether or not to include the
  root directory in the retrieved entries.

    !!! note

        If included, the root directory will also be a canonicalized, returning
        an absolute path and will not follow any of the other flags.

## Response

The directory entries contained with a `dir_entries` message.

```json
{
    "type": "dir_entries",
    "entries": [],
    "errors": []
}
```

### Fields

* `entries`: an array of directory entries, each being an object with the
  following fields:

    * `path`: the path to the entry within the directory.
    * `file_type`: the type associated with entry. One of *dir*, *file*, or
      *symlink*.
    * `depth`: how deep within the root directory this entry is with 0 being
      the root directory itself, 1 being a child within the directory, etc.

* `errors`: an array of errors encountered while traversing the directory. When
  the server is reading entries, it does not fail when some of the entries are
  not accessible, and instead captures the error and includes it here. The
  error format is the same as described in the [API error
  format](/reference/cli/json-api/messages/#errors).
