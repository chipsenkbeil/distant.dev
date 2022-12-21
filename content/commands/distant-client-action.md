---
title: distant-client-action
---

# NAME

distant-client-action - Performs some action on a remote machine

# SYNOPSIS

**distant-client-action** \[**\--cache**\] \[**\--connection**\]
\[**\--unix-socket**\] \[**\--windows-pipe**\] \[**-h**\|**\--help**\]
\[*TIMEOUT*\] \<*subcommands*\>

# DESCRIPTION

Performs some action on a remote machine

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

**-h**, **\--help**

:   Print help information

\[*TIMEOUT*\]

:   Represents the maximum time (in seconds) to wait for a network
    request before timing out

# SUBCOMMANDS

distant-client-action-capabilities(1)

:   Retrieve information about the servers capabilities

distant-client-action-file-read(1)

:   Reads a file from the specified path on the remote machine

distant-client-action-file-read-text(1)

:   Reads a file from the specified path on the remote machine and
    treats the contents as text

distant-client-action-file-write(1)

:   Writes a file, creating it if it does not exist, and overwriting any
    existing content on the remote machine

distant-client-action-file-write-text(1)

:   Writes a file using text instead of bytes, creating it if it does
    not exist, and overwriting any existing content on the remote
    machine

distant-client-action-file-append(1)

:   Appends to a file, creating it if it does not exist, on the remote
    machine

distant-client-action-file-append-text(1)

:   Appends text to a file, creating it if it does not exist, on the
    remote machine

distant-client-action-dir-read(1)

:   Reads a directory from the specified path on the remote machine

distant-client-action-dir-create(1)

:   Creates a directory on the remote machine

distant-client-action-remove(1)

:   Removes a file or directory on the remote machine

distant-client-action-copy(1)

:   Copies a file or directory on the remote machine

distant-client-action-rename(1)

:   Moves/renames a file or directory on the remote machine

distant-client-action-watch(1)

:   Watches a path for changes

distant-client-action-unwatch(1)

:   Unwatches a path for changes, meaning no additional changes will be
    reported

distant-client-action-exists(1)

:   Checks whether the given path exists

distant-client-action-metadata(1)

:   Retrieves filesystem metadata for the specified path on the remote
    machine

distant-client-action-search(1)

:   Searches filesystem using the provided query

distant-client-action-cancel-search(1)

:   Cancels an active search being run against the filesystem

distant-client-action-proc-spawn(1)

:   Spawns a new process on the remote machine

distant-client-action-proc-kill(1)

:   Kills a process running on the remote machine

distant-client-action-proc-stdin(1)

:   Sends additional data to stdin of running process

distant-client-action-proc-resize-pty(1)

:   Resize pty of remote process

distant-client-action-system-info(1)

:   Retrieve information about the server and the system it is on

distant-client-action-help(1)

:   Print this message or the help of the given subcommand(s)
