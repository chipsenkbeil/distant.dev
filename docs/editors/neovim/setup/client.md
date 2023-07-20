All settings found under the `client` key.

```lua
local plugin = require('distant')
plugin:setup({
   client = {}
})
```

### client.bin

<div class="grid" markdown>

=== "About"

    Path to the binary to use for distant on the local machine where neovim is
    running.

=== "Value"

    Path to the distant binary. **[default: distant** or **distant.exe]**

```lua title="Example"
{
    client = {
        bin = '/path/to/distant'
    }
}
```

</div>

### client.log_file

<div class="grid" markdown>

=== "About"

    Path where logging should be placed for the distant binary being used as
    the client. In other words, all of the local logging outside the plugin,
    server, and manager will go here.

=== "Value"

    Path to the log file. **[default: nil]**

```lua title="Example"
{
    client = {
        log_file = '/path/to/client.log'
    }
}
```

</div>

### client.log_level

<div class="grid" markdown>

=== "About"

    Logging level used for client-based logging tied to the distant binary.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```lua title="Example"
{
    client = {
        log_level = 'info'
    }
}
```

</div>
