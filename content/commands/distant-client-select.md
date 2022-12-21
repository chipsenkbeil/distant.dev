---
title: distant-client-select
---

# NAME

distant-client-select - Select the active connection

# SYNOPSIS

**distant-client-select** \[**\--cache**\] \[**-f**\|**\--format**\]
\[**\--unix-socket**\] \[**\--windows-pipe**\] \[**-h**\|**\--help**\]
\[*CONNECTION*\]

# DESCRIPTION

Select the active connection

# OPTIONS

**\--cache**=*CACHE* \[default: /Users/senkwich/Library/Caches/distant/cache.toml\]

:   Location to store cached data

**-f**, **\--format**=*FORMAT* \[default: shell\]

:   \
    *Possible values:*

    -   json: Sends and receives data in JSON format

    -   shell: Commands are traditional shell commands and output
        responses are inline with what is expected of a programs output
        in a shell

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)

\[*CONNECTION*\]

:   Connection to use, otherwise will prompt to select
