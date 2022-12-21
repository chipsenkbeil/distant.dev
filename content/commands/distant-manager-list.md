---
title: distant-manager-list
---

# NAME

distant-manager-list - List information about all connections

# SYNOPSIS

**distant-manager-list** \[**\--unix-socket**\] \[**\--windows-pipe**\]
\[**\--cache**\] \[**-h**\|**\--help**\]

# DESCRIPTION

List information about all connections

# OPTIONS

**\--unix-socket**=*UNIX_SOCKET*

:   Override the path to the Unix socket used by the manager (unix-only)

**\--windows-pipe**=*WINDOWS_PIPE*

:   Override the name of the local named Windows pipe used by the
    manager (windows-only)

**\--cache**=*CACHE* \[default: /Users/senkwich/Library/Caches/distant/cache.toml\]

:   Location to store cached data

**-h**, **\--help**

:   Print help information
