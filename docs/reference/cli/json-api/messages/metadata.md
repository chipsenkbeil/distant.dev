Read filesystem metadata for `path`.

## Request

```json
{
    "type": "metadata",
    "path": "...",
    "canonicalize": false,
    "resolve_file_type": false
}
```

### Fields

* `path`: absolute or relative path whose metadata to read.
 
* `canonicalize`: (optional, default: `false`) whether or not to canonicalize
  the path, returning the canonical, absolute form of the path as part
  of the response.

* `resolve_file_type`: (optional, default: `false`) if true, populates the
  returned file type with the underlying type referenced in the situation where
  the path points to a symlink. Otherwise, the file type will report `symlink`.

## Response

```json
{
    "type": "metadata",
    "canonicalized_path": "...",
    "file_type": "...",
    "len": 1234,
    "readonly": false,
    "accessed": 1234,
    "created": 1234,
    "modified": 1234,
    "unix": {},
    "windows": {}
}
```

### Fields

* `canonicalized_path`: (optional) canonicalized path to the file or directory,
  resolving symlinks and relative components, only included if flagged during
  the request.

* `file_type`: any one of *dir*, *file*, or *symlink*.

* `len`: size of the file/directory in bytes.

* `readonly`: whether or not the path is marked as unwriteable.

* `accessed`: (optional) represents the last time as a Unix timestamp (in
  seconds) when the path was accessed; can be optional as certain systems don't
  support this.

* `created`: (optional) represents the Unix timestamp (in seconds) when the
  path was created; can be optional as certain systems don't support this.

* `modified`: (optional) represents the Unix timestamp (in seconds) when the
  path was last modified; can be optional as certain systems don't support
  this.

* `unix`: (optional) an object comprised of additional metadata only available
  on Unix systems. All fields within the object are optional.

    | Name            | Description                                     |
    | -----------     | ----------------------------------------------- |
    | **owner_read**  | true if owner can read from the file            |
    | **owner_write** | true if owner can write to the file             |
    | **owner_exec**  | true if owner can execute the file              |
    | **group_read**  | true if associated group can read from the file |
    | **group_write** | true if associated group can write to the file  |
    | **group_exec**  | true if associated group can execute the file   |
    | **other_read**  | true if others can read from the file           |
    | **other_write** | true if others can write to the file            |
    | **other_exec**  | true if others can execute the file             |

* `windows`: (optional) an object comprised of additional metadata only
  available on Windows systems. All fields within the object are optional.

    | Name                      | Description                                                                                                   |
    | ------------------------- | ------------------------------------------------------------------------------------------------------------- |
    | **archive**               | represents whether or not a file or directory is an archive                                                   |
    | **compressed**            | represents whether or not a file or directory is compressed                                                   |
    | **encrypted**             | represents whether or not the file or directory is encrypted                                                  |
    | **hidden**                | represents whether or not a file or directory is hidden                                                       |
    | **integrity_stream**      | represents whether or not a directory or user data stream is configured with integrity                        |
    | **normal**                | represents whether or not a file does not have other attributes set                                           |
    | **not_content_indexed**   | represents whether or not a file or directory is not to be indexed by content indexing service                |
    | **no_scrub_data**         | represents whether or not a user data stream is not to be read by the background data integrity scanner       |
    | **offline**               | represents whether or not the data of a file is not available immediately                                     |
    | **recall_on_data_access** | represents whether or not a file or directory is not fully present locally                                    |
    | **recall_on_open**        | represents whether or not a file or directory has no physical representation on the local system (is virtual) |
    | **reparse_point**         | represents whether or not a file or directory has an associated reparse point, or a file is a symbolic link   |
    | **sparse_file**           | represents whether or not a file is a sparse file                                                             |
    | **system**                | represents whether or not a file or directory is used partially or exclusively by the operating system        |
    | **temporary**             | represents whether or not a file is being used for temporary storage                                          |
