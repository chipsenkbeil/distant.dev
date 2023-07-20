All settings found under the `network` key.

```lua
local plugin = require('distant')
plugin:setup({
   network = {}
})
```

### network.private

<div class="grid" markdown>

=== "About"

    If true, will create a private network for all operations associated with a
    singular neovim instance. Use this option if you want to avoid clashing
    with a pre-existing distant manager.

=== "Value"

    Boolean representing whether or not to use a private network. **[default:
    false]**

```lua title="Example"
{
    network = {
        private = false
    }
}
```

</div>

### network.timeout.max

<div class="grid" markdown>

=== "About"

    Maximum time to wait for requests to a remote server to complete.

=== "Value"

    Integer representing time in milliseconds. Set to 0 to disable. **[default:
    15 seconds]**

```lua title="Example"
{
    network = {
        timeout = {
            max = 15000
        }
    }
}
```

</div>

### network.timeout.interval

<div class="grid" markdown>

=== "About"

    Time to wait inbetween checks to see if a request timed out.

=== "Value"

    Integer representing time in milliseconds. **[default: 256]**

```lua title="Example"
{
    network = {
        timeout = {
            interval = 256
        }
    }
}
```

</div>

### network.windows_pipe

<div class="grid" markdown>

=== "About"

    Custom name to use for the Windows pipe that the distant manager uses for
    communication with neovim.

=== "Value"

    String representing the name of the local Windows pipe. **[default: nil]**

```lua title="Example"
{
    network = {
        windows_pipe = 'my-pipe'
    }
}
```

</div>

### network.unix_socket

<div class="grid" markdown>

=== "About"

    Custom path to a Unix domain socket that the distant manager uses for
    communication with neovim.

=== "Value"

    String representing the path to the Unix domain socket. **[default: nil]**

```lua title="Example"
{
    network = {
        unix_socket = '/path/to/distant.sock'
    }
}
```

</div>
