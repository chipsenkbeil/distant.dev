---
title: distant-client-shell
---

# NAME

distant-client-shell - Specialized treatment of running a remote shell
process

# SYNOPSIS

**distant-client-shell** \[**\--cache**\] \[**\--connection**\]
\[**\--unix-socket**\] \[**\--windows-pipe**\] \[**\--environment**\]
\[**-h**\|**\--help**\] \[*CMD*\]

# DESCRIPTION

Specialized treatment of running a remote shell process

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

**\--environment**=*ENVIRONMENT* \[default: \]

:   Environment variables to provide to the shell

**-h**, **\--help**

:   Print help information

\[*CMD*\]

:   Optional command to run instead of \$SHELL
