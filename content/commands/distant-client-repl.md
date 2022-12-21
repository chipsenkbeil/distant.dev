---
title: distant-client-repl
---

# NAME

distant-client-repl - Runs actions in a read-eval-print loop

# SYNOPSIS

**distant-client-repl** \[**\--cache**\] \[**\--connection**\]
\[**\--unix-socket**\] \[**\--windows-pipe**\] \[**-f**\|**\--format**\]
\[**-h**\|**\--help**\] \[*TIMEOUT*\]

# DESCRIPTION

Runs actions in a read-eval-print loop

# OPTIONS

**\--cache**=*CACHE* \[default: /Users/senkwich/Library/Caches/distant/cache.toml\]

:   Location to store cached data

**\--connection**=*CONNECTION*

:   Specify a connection being managed

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**-f**, **\--format**=*FORMAT* \[default: shell\]

:   Format used for input into and output from the repl\

\
*Possible values:*

> -   json: Sends and receives data in JSON format
>
> -   shell: Commands are traditional shell commands and output
>     responses are inline with what is expected of a programs output in
>     a shell

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)

\[*TIMEOUT*\]

:   Represents the maximum time (in seconds) to wait for a network
    request before timing out
