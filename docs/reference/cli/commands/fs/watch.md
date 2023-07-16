Watch a path for changes on the remote machine.

```sh
distant fs watch /path/to/file.txt
```

### Flags

* `--recursive`: indicates that a path should be watched recursively, meaning
  that if it is a directory, any changes within the directory will also be
  watched and reported (e.g. new file, changed contents, deleted within).
* `--only <EVENT>`: limit events being reported to only the one specified. This
  parameter can be provided more than once to limit to multiple different
  events.
* `--except <EVENT>`: limit events being reported to all but the one specified.
  This parameter can be provided more than once to exclude multiple events.

### Events

* `access`: reported when a file is accessed.
* `attribute`: reported when some attribute such as file permissions is
  changed.
* `close_write`: reported when a file is closed that was opened for writing.
* `close_no_write`: reported when a file is closed that was not opened for
  writing.
* `create`: reported when a file or directory is deleted. This only is reported
  within a recursively-watched directory.
* `delete`: reported when a file or directory is deleted.
* `modify`: reported when a file's contents are modified.
* `open`: reported when a file is opened.
* `rename`: reported when some path gets renamed.
* `unknown`: reported when some other event that is not supported is
  encountered.

### Notes

* Relative paths resolve to the current working directory of the server.

{{ run("distant fs watch --help", admonition="info") }}
