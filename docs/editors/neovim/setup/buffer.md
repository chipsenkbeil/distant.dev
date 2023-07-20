All settings found under the `buffer` key.

```lua
local plugin = require('distant')
plugin:setup({
   buffer = {}
})
```

### buffer.watch.enabled

<div class="grid" markdown>

=== "About"

    Indicates if file watching is enabled. When `true`, each file that is
    opened by distant will be watched for changes.

=== "Value"

    Boolean representing watch logic being enabled. **[default: false]**

```lua title="Example"
{
    buffer = {
        watch = {
            enabled = true
        }
    }
}
```

</div>

### buffer.watch.retry_timeout

<div class="grid" markdown>

=== "About"

    Amount of time between attempts to retry a watch request for a buffer when
    the path represented by the buffer does not exist.

=== "Value"

    Integer representing time in milliseconds. Set to 0 to disable. **[default:
    5000]**

```lua title="Example"
{
    buffer = {
        watch = {
            retry_timeout = 5000
        }
    }
}
```

</div>
