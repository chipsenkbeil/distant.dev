---
title: distant-client-action-dir-read
---

# NAME

distant-client-action-dir-read - Reads a directory from the specified
path on the remote machine

# SYNOPSIS

**distant-client-action-dir-read** \[**\--depth**\] \[**\--absolute**\]
\[**\--canonicalize**\] \[**\--include-root**\] \[**-h**\|**\--help**\]
\<*PATH*\>

# DESCRIPTION

Reads a directory from the specified path on the remote machine

# OPTIONS

**\--depth**=*DEPTH* \[default: 1\]

:   Maximum depth to traverse with 0 indicating there is no maximum
    depth and 1 indicating the most immediate children within the
    directory

**\--absolute**=*ABSOLUTE*

:   Whether or not to return absolute or relative paths

**\--canonicalize**=*CANONICALIZE*

:   Whether or not to canonicalize the resulting paths, meaning
    returning the canonical, absolute form of a path with all
    intermediate components normalized and symbolic links resolved

Note that the flag absolute must be true to have absolute paths
returned, even if canonicalize is flagged as true

**\--include-root**=*INCLUDE_ROOT*

:   Whether or not to include the root directory in the retrieved
    entries

If included, the root directory will also be a canonicalized, absolute
path and will not follow any of the other flags

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)

\<*PATH*\>

:   The path to the directory on the remote machine
