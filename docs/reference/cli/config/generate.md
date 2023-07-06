All generate settings fall under `#!toml [generate]`.

```toml
[generate]
log_level = "trace"
```

### log_file

<div class="grid" markdown>

=== "About"

    Specifies an alternative path to use when logging information related to
    generating some content.

=== "Value"

    String representing the path to the file.

```toml title="Example"
[generate]
log_file = "/path/to/file.log"
```

</div>

### log_level

<div class="grid" markdown>

=== "About"

    Specifies the log level used when logging information related to generating
    some content.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```toml title="Example"
[generate]
log_level = "info"
```

</div>
