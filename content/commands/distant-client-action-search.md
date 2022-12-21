---
title: distant-client-action-search
---

# NAME

distant-client-action-search - Searches filesystem using the provided
query

# SYNOPSIS

**distant-client-action-search** \[**\--target**\] \[**\--include**\]
\[**\--exclude**\] \[**\--follow-symbolic-links**\] \[**\--limit**\]
\[**\--max-depth**\] \[**\--pagination**\] \[**-h**\|**\--help**\]
\<*pattern*\> \[*PATHS*\]

# DESCRIPTION

Searches filesystem using the provided query

# OPTIONS

**\--target**=*TARGET* \[default: contents\]

:   Kind of data to examine using condition\

\
*Possible values:*

> -   path: Checks path of file, directory, or symlink
>
> -   contents: Checks contents of files

**\--include**=*INCLUDE*

:   Regex to use to filter paths being searched to only those that match
    the include condition

**\--exclude**=*EXCLUDE*

:   Regex to use to filter paths being searched to only those that do
    not match the exclude condition

**\--follow-symbolic-links**=*FOLLOW_SYMBOLIC_LINKS*

:   Search should follow symbolic links

**\--limit**=*LIMIT*

:   Maximum results to return before stopping the query

**\--max-depth**=*MAX_DEPTH*

:   Maximum depth (directories) to search

The smallest depth is 0 and always corresponds to the path given to the
new function on this type. Its direct descendents have depth 1, and
their descendents have depth 2, and so on.

Note that this will not simply filter the entries of the iterator, but
it will actually avoid descending into directories when the depth is
exceeded.

**\--pagination**=*PAGINATION*

:   Amount of results to batch before sending back excluding final
    submission that will always include the remaining results even if
    less than pagination request

**-h**, **\--help**

:   Print help information (use \`-h\` for a summary)

\<*pattern*\>

:   Condition to meet to be considered a match

\[*PATHS*\] \[default: .\]

:   Paths in which to perform the query
