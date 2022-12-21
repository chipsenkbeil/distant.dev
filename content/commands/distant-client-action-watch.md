---
title: distant-client-action-watch
---

# NAME

distant-client-action-watch - Watches a path for changes

# SYNOPSIS

**distant-client-action-watch** \[**\--recursive**\] \[**\--only**\]
\[**\--except**\] \[**-h**\|**\--help**\] \<*PATH*\>

# DESCRIPTION

Watches a path for changes

# OPTIONS

**\--recursive**=*RECURSIVE*

:   If true, will recursively watch for changes within directories,
    othewise will only watch for changes immediately within directories

**\--only**=*ONLY*

:   Filter to only report back specified changes\

\
\[*possible values: *access, access_close_execute, access_close_read,
access_close_write, access_open_execute, access_open_read,
access_open_write, access_read, access_time, create, content, data,
metadata, modify, remove, rename, rename_both, rename_from, rename_to,
size, ownership, permissions, write_time, unknown\]

**\--except**=*EXCEPT*

:   Filter to report back changes except these specified changes\

\
\[*possible values: *access, access_close_execute, access_close_read,
access_close_write, access_open_execute, access_open_read,
access_open_write, access_read, access_time, create, content, data,
metadata, modify, remove, rename, rename_both, rename_from, rename_to,
size, ownership, permissions, write_time, unknown\]

**-h**, **\--help**

:   Print help information

\<*PATH*\>

:   The path to the file, directory, or symlink on the remote machine
