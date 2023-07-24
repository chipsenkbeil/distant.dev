For buffers managed by distant, the plugin interface exposes a `buf` field that
enables you to access and manipulate distant-specific information tied to a
buffer as well as search for specific remote buffers.

## Buffer interface

By default, if you access the `buf` field, all data operations will apply to
the current buffer:

```lua
-- Will retrieve distant-specific data for the current buffer
plugin.buf.get_data()
```

If you want to access or manipulate data for a specific buffer, you can instead
invoke `buf` as a function, providing the buffer's id as the argument:

```lua
-- Will retrieve distant-specific data for buffer whose number is 123
plugin.buf(123).get_data()
```

## Data API

The primary API exposed by the buffer interface is retrieving and manipulating
distant-specific information. All of the information is stored in the
buffer-local variable `distant`, which you can access within neovim through the
scoped variable `b:distant`.

The buffer interface exposes methods to simplify accessing and manipulating
specific portions or the entire data stored in the buffer.

### Data table

If you directly access the data stored in `b:distant`, you will find a table
comprised of the following fields, not all of which may be present:

| Field     | Description                                                                  |
| -----     | -----------                                                                  |
| client_id | Numeric id of the connection associated with the buffer                      |
| path      | Path on the remote machine (no scheme)                                       |
| alt_paths | Alternative paths, usually relative, that also map to the primary path       |
| type      | Indicates the path type (`dir` or `file`)                                    |
| mtime     | Numeric UNIX timestamp (in seconds) representing last modified time remotely |
| watched   | Watched state, which can be `false`, `true`, or `"locked"`                   |

#### Retrieving data

You can retrieve the data as a Lua table using `data` like below:

```lua
-- This can be a Lua table or nil if b:distant is not present
local data = plugin.buf.data()
```

If you want to check for the presence of data before accessing it, you can use
the `has_data` function:

```lua
if plugin.buf.has_data() then
    -- Do something if the buffer has data.
    -- You can use this to assert that a buffer is remote!
end
```

#### Modifying data

If you want to modify the data as a whole, there are two means to do this:

1. Call `set_data(data)`, passing it a new table to use. Be careful with this
   method, is it is easy to corrupt the state of a buffer. Prefer more specific
   methods instead.
2. Call `mutate_data(fn)`, which takes a function to modify and return a table
   to be used as the new data.

```lua
-- Set distant data directly
-- Will return true if successful
plugin.buf.set_data({ client_id = 123, path = '/path/to/file.txt' })

-- Mutate distant data
-- Will return true if successful
plugin.buf.mutate_data(function(data)
  data.path = '/path/to/file.txt'
  return data
end)
```

Lastly, if you want to remove all remote information from a buffer, you can
call `clear`; however, this is discouraged unless you REALLY know what you are
doing:

```lua
-- Will return true if successful
plugin.buf.clear()
```

### Client id

If you need to work with the client id (aka connection) associated with the
buffer, there are two methods:

* `set_client_id(id)` is used to update the client id of the buffer
* `client_id()` is used to retrieve the client id of the buffer

```lua
local id = plugin.buf.client_id()

-- Will return true if successful
plugin.buf.set_client_id(123)
```

### Path

Representing the primary remote path associated with the buffer, this is
populated when a file or directory is first opened. The `path` should be the
canonicalized path provided by the server, meaning that any symlinks or
relative components are resolved.

* `set_path(path)` is used to update the buffer's path
* `path()` is used to retrieve the buffer's path

```lua
local path = plugin.buf.path()

-- Will return true if successful
plugin.buf.set_path('/path/to/file.txt')
```

### Alternate paths

Representing the alternative remote path associated with the buffer, this is a
list of strings representing other paths that evaluate to the `path` when they
are canonicalized. This list is updated whenever a request to open a path is
provided that resolves to an existing buffer's path. For instance, if `.`
resolves to `/path/to/file.txt` and you then open `/path/to/./file.txt`, the
alternative paths should include both `.` and `/path/to/./file.txt`.

* `set_alt_paths(paths)` is used to update the buffer's alternate paths
* `add_alt_path(path, opts)` is used to append the path to the buffer's
  alternate paths. Opts is an optional table, where specifying `dedup = true`
  will result in the alternate paths being deduplicated.
* `alt_paths()` is used to retrieve the buffer's alternate paths

```lua
-- List of paths: { '.', '/path/to/./file.txt' }
local paths = plugin.buf.alt_paths()

-- Append a path to our list
plugin.buf.add_alt_path('./file.txt')

-- Append a path to our list and deduplicate the list
plugin.buf.add_alt_path('./file.txt', { dedup = true })

-- Will return true if successful
plugin.buf.set_alt_paths({ '.', '/path/to/./file.txt' })
```

### Type

Representing the file type of the remote path associated with the buffer, this
is populated when a file or directory is first opened.

* `set_type(ty)` is used to update the buffer's type
* `type()` is used to retrieve the buffer's type

```lua
-- Could be 'dir' or 'file'
local ty = plugin.buf.type()

-- Will return true if successful
plugin.buf.set_type('dir')
```

### Modification time

Representing the last time (in seconds as Unix timestamp) the remote path
associated with the buffer was modified. This is populated when a file or
directory is first opened, and is updated whenever the file is reopened,
written to locally, or a watch event is received for this buffer's path.

* `set_mtime(mtime)` is used to update the buffer's modification time
* `mtime()` is used to retrieve the buffer's modification time

```lua
local mtime = plugin.buf.mtime()

-- Will return true if successful
plugin.buf.set_mtime(1234)
```

### Watched

Representing the watch status of the remote path associated with the buffer.
This is populated when a file or directory is first opened, and is updated
whenever during the process of watching a file and once a file is successfully
being watched.

* `set_watched(watched)` is used to update the buffer's watch status
* `watched()` is used to retrieve the buffer's watch status

```lua
-- Could be false (not watched), true (actively watching), or "locked" meaning
-- that the file is in the process of being watched or avoiding triggering
-- watch events (such as when writing the file from neovim)
local watched = plugin.buf.watched()

-- Will return true if successful
plugin.buf.set_watched(true)
```

## Name API

Another feature available through the buffer interface is working with buffer
names. In order for distant to operate on multiple connections, it uses a
distinct name format that encodes both a scheme (`distant`) and a client id
(aka connection). There are two supported ways that this name can be
represented:

* `modern` - `[{SCHEME}[+{CONNECTION}]://PATH` (e.g.
  `distant+1234://some/file.txt`)
* `legacy` - `[{SCHEME}://[{CONNECTION}://]PATH` (e.g.
  `distant://1234://some/file.txt`)

!!! note

    As of today, neovim will always use the `legacy` format. If
    [neovim/23834](https://github.com/neovim/neovim/pull/23834) gets
    implemented, we can detect the neovim version and use the modern format;
    otherwise, we will be stuck with "legacy" forever.

All name API methods are accessible from the `name` table:

```lua
plugin.buf.name.parse('...')
```

### Default format

Returns the default format used for parsing and building a buffer's name. Until
[neovim/23834](https://github.com/neovim/neovim/pull/23834) is merged, this
will return `legacy`:

```lua
local format = plugin.buf.name.default_format()
assert(format == 'legacy')
```

### Prefix

Returns the prefix tied to the buffer's name, a provided name, or builds a
prefix from the given components. The function accepts an optional table to
dictate what to parse or use to construct the prefix.

#### Parsing from an explicit name

If you provide `name`, it will be parsed for the prefix:

```lua
-- You can supply an optional `format` field to override the prefix format
-- such as `format = 'legacy'`
local prefix = plugin.buf.name.prefix({ name = 'distant://1234//some/file.txt' })
assert(prefix == 'distant://1234')
```

#### Parsing from the buffer's name

If you provide no `name` or `scheme`, the buffer's name will be retrieved and
parsed for the prefix:

```lua
-- You can supply an optional table to override the prefix format
-- using { format = 'legacy' }
local prefix = plugin.buf.name.prefix()

-- Assuming the buffer's name was something like distant://1234://some/file.txt
assert(prefix == 'distant://1234')
```

#### Building from components

If you provide a `scheme` and an optional `connection`, it will be used to
build a prefix:

```lua
-- You can supply an optional `format` field to override the prefix format
-- such as `format = 'legacy'`
local prefix = plugin.buf.name.prefix({ scheme = 'distant', connection = 1234 })
assert(prefix == 'distant://1234')
```

### Building a name

The `build` function is provided to construct a complete buffer name. The
function takes a single table as an argument, which is comprised of these
fields:

* `path`: (required) the path to the file or directory.
* `scheme`: (optional) the scheme to use. Ideally, this is `distant`. If you do
  not supply a scheme, the name created will resemble a local buffer.
* `connection`: (optional) the id of the specific connection tied to the
  buffer. If you do not supply one, it will not be included, which means that
  the buffer would be represented by the active connection. In most cases, you
  will want to provide the connection's id to ensure the buffer doesn't switch
  to a different remote machine.
* `format`: (optional) the format to use when constructing the name. If not
  supplied, this will leverage `default_format()`.

```lua
local name = plugin.buf.name.build({
    path = 'some/file.txt',
    scheme = 'distant',
    connection = 1234,
    format = 'legacy',
})
assert(name == 'distant://1234://some/file.txt')
```

### Parsing a name

The `parse` function is provided to parse a buffer's name into its components.
The function takes an optional table as an argument, which is comprised of
these fields:

* `name`: (optional) the buffer name to parse. If not provided, will parse the
  buffer's name.
* `format`: (optional) the format to use when parsing the name. If not
  supplied, this will leverage `default_format()`.

The returned value is a table that contains one or more of these fields:

* `path`: the path represented by the buffer. This will always be populated.
* `connection`: the numeric id of the connection. Will only appear if contained
  in the parsed name.
* `scheme`: the scheme associated with the buffer. Will only appear if
  contained in the parsed name.

```lua
-- Parses the current buffer's name with the default format
local pieces = plugin.buf.name.parse()

-- Parses the specific buffer's name with the default format
local pieces = plugin.buf(123).name.parse()

-- Parses the specific name with the default format
local pieces = plugin.buf.name.parse({ name = 'distant://1234://some/file.txt' })
assert(pieces.path == 'some/file.txt')
assert(pieces.connection == 1234)
assert(pieces.scheme == 'distant')
```

## Search API

Alongside the other APIs, the buffer interface also exposes a simplified
experience in locating buffers by their paths. Specifically, there are three
methods available:

* `has_matching_path(path, opts)`: checks if the buffer has a matching path
  within its `path` or `alt_paths` data. The opts table is optional and can
  contain a `connection` field to require that the buffer not only has the
  specified `path` but also is the same connection.

* `find(opts)`: searches through all buffers for one that that meets the
  specified conditions. If a match is found, a buffer interface is returned for
  the matched buffer:

    * `opts.path`: looks for a buffer with the specified path either as its
      `path` or within its `alt_paths`.
    * `opts.connection`: if provided, will limit the search to only buffers
      with the specified connection id.
    * `opts.format`: format of buffer names to search. If not provided, uses
      `name.default_format()`.

* `find_bufnr(opts)`: same as `find(opts)`, but returns the number of the
  buffer instead of the buffer interface.

```lua
-- Check if the current buffer is pointing to the specified path for the
-- specific connection
if plugin.buf.has_matching_path('some/file.txt', { connection = 1234 }) then
    -- Do something
end

-- Search for a buffer, returning nil if nothing found
-- The returned buffer has the same buffer interface
local buffer = plugin.buf.find({ path = '.', connection = 1234 })
if buffer then
    -- Print out the buffer's number
    print(buffer.bufnr())

    -- Print out the true path of the buffer
    print(buffer.path())
end

-- Retrieves the id of the buffer above, returning nil if not found
local bufnr = plugin.buf.find_bufnr({ path = '.', connection = 1234 })
```
