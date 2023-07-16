Sets permissions for the specified path on the remote machine.

```sh
distant fs set-permissions readonly /path/to/file.txt
```

### Flags

* `--recursive`: indicates that permissions should be applied to all paths
  contained within the specified when it is a directory, meaning that the
  children, their children, etc. will all have the permissions applied.
* `--follow-symbolic-links`: indicates that symbolic links will be traversed
  when setting permissions, which means applying the permissions to the
  underlying file or directory, not the symlink itself. In the case of Windows,
  the permissions are always set on the underlying file or directory.

### Examples

#### Using readonly/notreadonly

When working with Windows, it may be easier to consider read-only status of a
file or directory as Unix permissions don't apply. While Unix permissions
altering the read-only status will still take effect, you can instead use the
keyword `readonly` or `notreadonly` to explicitly target that attribute.

In the case of Unix, this will set or clear the read-only permission across
owner, group, and others!

```sh
# Disable writing
distant fs set-permissions readonly /path/to/file.txt

# Enable writing
distant fs set-permissions notreadonly /path/to/file.txt
```

#### Using absolute mode

Similar to `chmod`, you can provide an explicit octal value to indicate the
read, write, and execute permissions:

```sh
distant fs set-permissions 755 /path/to/file.txt
```

#### Using symbolic mode

Also similar to `chmod`, you can provide a series of permission symbols to
represent what you want to apply such as `go-w` to deny write permission to
group and others:

```sh
distant fs set-permissions 'go-w' /path/to/file.txt
```

!!! warning

    This is broken on version 0.20.0 ({{ issue(221) }})! Using this approach
    will apply only the specified symbolic permissions and clear any
    pre-existing permissions! In the above example, this will result in a file
    with permissions of `000` instead of just removing the group & other write
    permission.

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs set-permissions --help", admonition="info") }}
