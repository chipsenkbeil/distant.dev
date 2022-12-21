---
title: distant-client-action-metadata
---

# NAME

distant-client-action-metadata - Retrieves filesystem metadata for the
specified path on the remote machine

# SYNOPSIS

**distant-client-action-metadata** \[**\--canonicalize**\]
\[**\--resolve-file-type**\] \[**-h**\|**\--help**\] \<*PATH*\>

# DESCRIPTION

Retrieves filesystem metadata for the specified path on the remote
machine

# OPTIONS

**\--canonicalize**=*CANONICALIZE*

:   Whether or not to include a canonicalized version of the path,
    meaning returning the canonical, absolute form of a path with all
    intermediate components normalized and symbolic links resolved

**\--resolve-file-type**=*RESOLVE_FILE_TYPE*

:   Whether or not to follow symlinks to determine absolute file type
    (dir/file)

**-h**, **\--help**

:   Print help information

\<*PATH*\>

:   The path to the file, directory, or symlink on the remote machine
