The distant plugin comes with a vast API available in Lua. All of the public
API methods are accessible through the top-level plugin object made available
from requiring distant:

```lua
local plugin = require('distant')
```

<div class="grid cards" markdown>

-   :material-clock-fast:{ .lg .middle } __Initialization__

    ---

    See how the plugin is initialized and how you can verify the plugin is
    ready to be used.

    [:octicons-arrow-right-24: Initialization](initialization)

-   :simple-lua:{ .lg .middle } __Connection Management__

    ---

    Manage connections directly in Lua.

    [:octicons-arrow-right-24: Connection Management](connections)

-   :octicons-command-palette-16:{ .lg .middle } __Settings__

    ---

    Access and modify settings tied to the plugin.

    [:octicons-arrow-right-24: Settings](settings)

-   :material-folder:{ .lg .middle } __API__

    ---

    Explore the full power of distant through a Lua interface to its API.

    [:octicons-arrow-right-24: API](api)

-   :material-power-plug-outline:{ .lg .middle } __Buffers__

    ---

    Access remote-specific information tied to buffers managed by this plugin.

    [:octicons-arrow-right-24: Buffers](buffers)

-   :octicons-question-16:{ .lg .middle } __Editor__

    ---

    Directly invoke editor-specific functions.

    [:octicons-arrow-right-24: Editor](editor)

-   :octicons-question-16:{ .lg .middle } __Events__

    ---

    Tap into the events exposed by the plugin for greater insight and control.

    [:octicons-arrow-right-24: Events](events)

-   :octicons-question-16:{ .lg .middle } __Shells__

    ---

    Spawn shells to remote machines directly using Lua.

    [:octicons-arrow-right-24: Shells](shells)

-   :octicons-question-16:{ .lg .middle } __Wrapping Commands__

    ---

    Wrap commands to be executed on the remote machine, enabling easier
    integration with other plugins that take command strings.

    [:octicons-arrow-right-24: Wrapping commands](wrapping)

-   :octicons-question-16:{ .lg .middle } __Version__

    ---

    Understand the version of the plugin being used from Lua.

    [:octicons-arrow-right-24: Version](version)

-   :octicons-question-16:{ .lg .middle } __Utilities__

    ---

    Check out additional utility functions exposed by the plugin.

    [:octicons-arrow-right-24: Utilities](utilities)

</div>
