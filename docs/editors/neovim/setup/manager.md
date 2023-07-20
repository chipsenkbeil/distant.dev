All settings found under the `manager` key.

```lua
local plugin = require('distant')
plugin:setup({
   manager = {}
})
```

### manager.daemon

<div class="grid" markdown>

=== "About"

    Indicate when neovim starts a manager if it will be run as a daemon, which
    will detach it from the neovim process. This means that the manager will
    persist after neovim itself exits.

=== "Value"

    Boolean representing whether or not to run the manager as a daemon.
    **[default: false]**

```lua title="Example"
{
    manager = {
        daemon = false
    }
}
```

</div>

### manager.lazy

<div class="grid" markdown>

=== "About"

    Indicate if the distant manager should be started eagerly or wait until the
    first time distant is needed in neovim.

=== "Value"

    Boolean representing whether or not to avoid starting the distant manager
    until first needed. **[default: true]**

```lua title="Example"
{
    manager = {
        lazy = true
    }
}
```

</div>

### manager.log_file

<div class="grid" markdown>

=== "About"

    Path where logging should be placed for the distant binary being used as
    the manager. This is only used when neovim starts the manager itself.

=== "Value"

    Path to the log file. **[default: nil]**

```lua title="Example"
{
    manager = {
        log_file = '/path/to/manager.log'
    }
}
```

</div>

### manager.log_level

<div class="grid" markdown>

=== "About"

    Logging level used for manager-based logging tied to the distant binary.

=== "Value"

    String representing the level. **[default: info]**
    Choices are off, error, warn, info, debug, trace.

```lua title="Example"
{
    manager = {
        log_level = 'info'
    }
}
```

</div>

### manager.user

<div class="grid" markdown>

=== "About"

    When neovim starts the distant manager, indicates whether to have the
    manager listen on a global or user-specific channel, which is dependent on
    the operating system.

=== "Value"

    Boolean representing whether or not to have the distant manager listen on a
    user-local channel. **[default: false]**

```lua title="Example"
{
    manager = {
        user = false
    }
}
```

</div>
