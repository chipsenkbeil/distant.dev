Searches a filesystem using a `query` to find matches in file contents or
paths.

## Request

```json
{
    "type": "search",
    "query": {
        "target": "...",
        "condition": {},
        "paths": [],
        "options": {
            "allowed_file_types": [],
            "include": {},
            "exclude": {},
            "upward": false,
            "follow_symbolic_links": false,
            "limit": 1234,
            "max_depth": 1234,
            "pagination": 1234,
            "ignore_hidden": false,
            "use_ignore_files": false,
            "use_parent_ignore_files": false,
            "use_git_ignore_files": false,
            "use_global_git_ignore_files": false,
            "use_git_exclude_files": false
        }
    }
}
```

### Fields

* `query`: object containing the details of the search to perform.

    * `target`: what to search for matches.
        
        * *contents*: indicates to look through the contents of files.

        * *path*: indicates to look through file paths. For example, you can
          provide a search for all paths that contain `Cargo.toml`.

    * `condition`: the criteria to check for a match. This is an object with a
      `type` field to indicate what kind of match to perform. There is also a
      `value` field that varies per match type.

        * *contains*: with this type, `value` is a string representing the text
          that must be contained within a file's contents or path depending on
          the `target`.

        * *ends_with*: with this type, `value` is a string representing the
          text that must be at the end of a file's contents (per line) or path
          depending on the `target`.

        * *equals*: with this type, `value` is a string representing the text
          that must exactly equal file's contents (per line) or path depending
          on the `target`.

        * *or*: with this type, `value` is a nested array of `condition`s. For
          example, two separate *contains* conditions can be provided where a
          match is valid if either is a match.

        * *regex*: with this type, `value` is a string representing some
          regular expression to apply to a file's contents (per line) or path
          depending on the `target`.

        * *starts_with*: with this type, `value` is a string representing the
          text that must be at the beginning of a file's contents (per line) or
          path depending on the `target`.

    * `paths`: an array of strings representing the paths to search for a
      match with logic based on `target` and `condition`.

    * `options`: (optional) object containing additional constraints to place
      on the search as it is performed. All fields within this object are
      optional, as is the object itself.

        * `allowed_file_types`: (optional) restrict search to only these file
          types (otherwise all are allowed). Types are *dir*, *file*, and
          *symlink*.

        * `include`: (optional) condition to use to filter paths being searched
          to only those that match the include condition. Applies the condition
          to each path being examined, regular of the `target`. This is the
          same format as the `condition` field.

        * `exclude`: (optional) condition to use to filter paths being searched
          to only those that do not match the exclude condition. Applies the
          condition to each path being examined, regular of the `target`. This
          is the same format as the `condition` field.

        * `upward`: (optional) if true, will search upward through parent
          directories rather than the traditional downward search that recurses
          through all children directories.

            Note that this will use maximum depth to apply to the reverse
            direction, and will only look through each ancestor directory's
            immediate entries. In other words, this will not result in
            recursing through sibling directories.

            An upward search will ALWAYS search the contents of a directory, so
            this means providing a path to a directory will search its entries
            EVEN if the max_depth is 0.

        * `follow_symbolic_links`: (optional) if true, search should follow
          symbolic links when examining files & directories.

        * `limit`: (optional) maximum results to return before stopping the
          search.

        * `max_depth`: (optional) maximum depth (directories) to search.
    
             The smallest depth is 0 and always corresponds to the path given
             to the new function on this type. Its direct descendents have
             depth 1, and their descendents have depth 2, and so on.
            
             Note that this will not simply filter the entries of the iterator,
             but it will actually avoid descending into directories when the
             depth is exceeded.

        * `pagination`: (optional) amount of results to batch before sending
          back excluding final submission that will always include the
          remaining results even if less than pagination request.

        * `ignore_hidden`: (optional) if true, will skip searching hidden
          files.

        * `use_ignore_files`: (optional) if true, will read `.ignore` files
          that are used by `ripgrep` and `The Silver Searcher` to determine
          which files and directories to not search.

        * `use_parent_ignore_files`: (optional) if true, will read `.ignore`
          files from parent directories that are used by `ripgrep` and `The
          Silver Searcher` to determine which files and directories to not
          search.

        * `use_git_ignore_files`: (optional) If true, will read `.gitignore`
          files to determine which files and directories to not search.

        * `use_global_git_ignore_files`: (optional) if true, will read global
          `.gitignore` files to determine which files and directories to not
          search.

        * `use_git_exclude_files`: (optional) if true, will read
          `.git/info/exclude` files to determine which files and directories to
          not search.

## Response

The immediate response will be a confirmation that a search started with a
numeric `id` associated with the search:

```json
{
    "type": "search_started",
    "id": 1234
}
```

### Search results

As results are acquired, they can be returned as a collection of matches. The
rate at which the results are returned is controlled by the `pagination`
option.

By default, only a singular collection of results is returned once the search
finishes, but before the `search_done` response is sent. Pagination enables
control of how many matches are collected before a `search_results` message is
sent.

```json
{
    "type": "search_results",
    "id": 1234,
    "matches": []
}
```

The `id` field is the same as the one provided in `search_started`. The
`matches` field contains a collection of objects, each being a singular match
for the earlier query.

#### Contents search results

When `target` is set to *contents*, each match will be in this format:

```json
{
    "type": "contents",
    "path": "...",
    "lines": [] | {},
    "line_number": 1234,
    "absolute_offset": 1234,
    "submatches": []
}
```

* `type`: will always be the string *contents*.
* `path`: is the path to the file, directory, or symlink that matched.
* `lines`: is the matching data for one or more lines, either as a byte
  array or a string. If the data is UTF-8 format, it will be a string,
  otherwise binary matches are possible.
* `line_number`: line number where the match starts (base index 1).
* `absolute_offset`: absolute byte offset corresponding to the start of `lines`
  in the data being searched.
* `submatches`: collection of objects representing singular submatches tied to
  `lines` where each submatch's byte offset is relative to `lines` and not the
  overall content.

    * `match`: same as `lines` (byte array or string), but only for the
      specific submatch's contents.
    * `start`: byte offset representing start of submatch (inclusive).
    * `end`: byte offset representing end of submatch (exclusive).

#### Path search results

When `target` is set to *path*, each match will be in this format:

```json
{
    "type": "path",
    "path": "...",
    "submatches": []
}
```

* `type`: will always be the string *contents*.
* `path`: is the path that matched.
* `submatches`: collection of objects representing singular submatches tied to
  `path` where each submatch's byte offset is relative to `path`.

    * `match`: same as `path`, but only for the specific submatch's contents.
    * `start`: byte offset representing start of submatch (inclusive).
    * `end`: byte offset representing end of submatch (exclusive).

### Search done

When a search finishes, a final message will be sent with a `type` and `id`
where the `id` is the same as the one received from the `search_started`
message:

```json
{
    "type": "search_done",
    "id":1234 
}
```
