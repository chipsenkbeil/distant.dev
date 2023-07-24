A version is a specialized Lua table that provides a structured view into a
[Semantic Version](https://semver.org/). The version table has the following
fields:

* `major`: major version, which will always exist.
* `minor`: (optional) minor version. If `nil`, logically this will be treated
  as 0 for other methods.
* `patch`: (optional) patch version. If `nil`, logically this will be treated
  as 0 for other methods.
* `prerelease`: (optional) prerelease version as a list of strings. If `nil`,
  will be ignored for other methods.
* `build`: (optional) build version as a list of strings. Is not used in other
  methods.

### Constructor

If you want to create a version, this can be done using the `new` method, which
takes a table comprised of one or more of the version fields:

```lua
local version = Version:new({
    major = 1,
    minor = 2,
    patch = 3,
    prerelease = { 'alpha', '4' },
    build = { '2023', '07', '24' },
})
assert(version:as_string(), '1.2.3-alpha.4+2023.07.24')
```

### Parsing

Supports `parse(semver, opts)` and `try_parse(semver, opts)` methods.

TODO

### Incrementing

Supports `inc(level)`.

TODO

### Comparing versions

Supports `cmp(other)` and `compatible(version)`. Also implements `__le`,
`__lt`, `__eq`, `__gt`, and `__ge`.

TODO

### Converting to string

Supports `as_string()` and `__tostring()`.

TODO

### Prerelease

Supports `has_prerelease()` and `prerelease_string()`.

TODO

### Build

Supports `has_build()` and `build_string()`.

TODO
