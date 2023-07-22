During the plugin's lifetime, there are a variety of events that occur such as
the active connection changing. You can listen to these events and respond
using Lua callbacks.

* `connection:changed`: triggered whenever the active connection changes.
* `manager:started`: triggered when a manager was not running and was therefore
  started by this plugin.
* `manager:loaded`: triggered when a manager is loaded for the first time,
  which can occur both from starting a manager or connecting to an existing
  one.
* `setup:finished`: triggered when the call to `setup()` completes.

### plugin:on(event, handler)

This function ties a `handler` to an event, invoking the handler whenever the
event is emitted. Handlers accept a single payload as part of the event
emission, which can hold data relevant to the specific event. The following
events have a payload:

* `connection:changed`: payload is the client tied to the connection.
* `manager:started`: payload is the manager that was started.
* `manager:loaded`: payload is the manager that was loaded.

```lua title="Example"
plugin:on('connection:changed', function(client)
  -- Use the client tied to the connection
end)
```

### plugin:once(event, handler)

Similar to `plugin:on`, this function also takes a `handler` to tie to an
event, but the handler is only triggered once before it is disassociated with
the event.

```lua title="Example"
plugin:once('connection:changed', function(client)
  -- Use the client tied to the connection
end)
```

### plugin:off(event, handler)

This function disables event emission for a specific handler that was
registered earlier.

```lua title="Example"
function handler()
end

-- Enable the handler for an event
plugin:on('connection:changed', handler)

-- Disable the handler for the same event
plugin:off('connection:changed', handler)
```
