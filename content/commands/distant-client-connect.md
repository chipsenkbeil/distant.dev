---
title: distant-client-connect
---

# NAME

distant-client-connect - Requests that active manager connects to the
server at the specified destination

# SYNOPSIS

**distant-client-connect** \[**\--cache**\] \[**\--options**\]
\[**\--unix-socket**\] \[**\--windows-pipe**\] \[**-f**\|**\--format**\]
\[**-h**\|**\--help**\] \<*DESTINATION*\>

# DESCRIPTION

Requests that active manager connects to the server at the specified
destination

# OPTIONS

**\--cache**=*CACHE* \[default: /Users/senkwich/Library/Caches/distant/cache.toml\]

:   Location to store cached data

**\--options**=*OPTIONS* \[default: \]

:   Additional options to provide, typically forwarded to the handler
    within the manager facilitating the connection. Options are
    key-value pairs separated by comma.

E.g. \`key=\"value\",key2=\"value2\"\`

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**-f**, **\--format**=*FORMAT* \[default: shell\]

:   \
    *Possible values:*

    -   json: Sends and receives data in JSON format

    -   shell: Commands are traditional shell commands and output
        responses are inline with what is expected of a programs output
        in a shell

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)

\<*DESTINATION*\>

:   
