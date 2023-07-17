Sets filesystem permissions for `path`.

## Request

```json
{
    "type": "set_permissions",
    "path": "...",
    "permissions": {
        "owner_read": true,
        "owner_write": true,
        "owner_exec": true,
        "group_read": true,
        "group_write": true,
        "group_exec": true,
        "other_read": true,
        "other_write": true,
        "other_exec": true
    },
    "options": {
        "exclude_symlinks": false,
        "follow_symlinks": false,
        "recursive": false
    }
}
```

### Fields

* `path`: absolute or relative path whose permissions to set.
 
* `permissions`: an object containing a field per possible permission to set.
  The full suite of permissions matches a Unix permission set, but this can
  also be used on Windows where the write flag will be used to determine if the
  path should be set to readonly (write is false) or not (write is true).

    All fields within the permissions object are optional, and only those set
    to `true` or `false` will be applied to the path.

    | Name            | Description                                                          |
    | -----------     | -----------------------------------------------                      |
    | **owner_read**  | true/false to change whether owner can read from the file            |
    | **owner_write** | true/false to change whether owner can write to the file             |
    | **owner_exec**  | true/false to change whether owner can execute the file              |
    | **group_read**  | true/false to change whether associated group can read from the file |
    | **group_write** | true/false to change whether associated group can write to the file  |
    | **group_exec**  | true/false to change whether associated group can execute the file   |
    | **other_read**  | true/false to change whether others can read from the file           |
    | **other_write** | true/false to change whether others can write to the file            |
    | **other_exec**  | true/false to change whether others can execute the file             |

* `options`: (optional, default: `undefined`) additional options that can be
  applied when setting permissions.

    * `exclude_symlinks`: (optional, default: `false`) if true, symlinks will
      be ignored when traversing directories to set permissions.
    * `follow_symlinks`: (optional, default: `false`) if true, symlinks will
      be followed when traversing directories to set permissions. Note that
      this does not NOT influence setting permissions when encountering a
      symlink as most systems will resolve symlinks before setting permissions.
    * `recursive`: (optional, default: `false`) if true, will navigate the
      contents of directories to set permissions, rather than just the
      directories themselves.

## Response

```json
{
    "type": "ok"
}
```
