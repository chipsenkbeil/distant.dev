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

Outside of creating a version manually, you can also parse a string into a
version using either `parse` or `try_parse`. Both perform the same work, but
`parse` will throw an error if the string does not follow semantic versioning
whereas `try_parse` will return `nil` in the case that parsing fails.

Both functions have a signature that takes two arguments: a string and an
optional table of options. For the options table, you can provide `strict =
true` to force the version to have a major, minor, and patch component,
otherwise values like `1` will translate to `1.0.0`, etc.

```lua
-- Parses full version, populating all relevant fields
local version = Version:parse('1.2.3-alpha.4+2023.07.24')

-- Throws error because not a version
Version:parse('abc')

-- Throws error because not a complete version
Version:parse('1', { strict = true })
```

### Incrementing

In a situation where you have a version and want to increment it, you can use
the `inc(level)` method. This increments this version by the specified `level`,
returning a new copy as a result.

The `level` supplied can be one of the following strings: `major`, `minor`, or
`patch`. In the event that you do not supply a level, `patch` will be used.

In the case where `minor` or `patch` are not set in the version, they will be
set to 0 prior to incrementing.

```lua
-- Increment the patch version, going from 1.2.3 -> 1.2.4
local version = Version:new({ major = 1, minor = 2, patch = 3 }):inc()
assert(version:as_string() == '1.2.4')

-- Increment the minor version, going from 1 -> 1.1.0
local version = Version:new({ major = 1 }):inc('minor')
assert(version:as_string() == '1.1.0')

-- Increment the major version, going from 1.2.3 -> 2.0.0
local version = Version:new({ major = 1, minor = 2, patch = 3 }):inc('major')
assert(version:as_string() == '2.0.0')
```

### Comparing & compatibility

A common practice when working with versions it to compare them. To that end,
you can use the `cmp(other)` or `compatible(version)` methods. In addition, the
version table implements the metatable functions for `__le`, `__lt`, `__eq`,
`__gt`, and `__ge` utilizing the `cmp` function for order and equality.

For `cmp`, the version is compared with `other` following semver 2.0.0
specification:

* Returns -1 if lower precedence than `other` version.
* Returns 0 if equal precedence to `other` version.
* Returns 1 if higher precedence than `other` version.
* Missing `minor` and `patch` versions are treated as 0.

```lua
-- a < b, therefore returns -1
local a = Version:parse('1.2.3')
local b = Version:parse('1.3.0')
assert(a:cmp(b) == -1)
```

For `compatible`, this follows both [Semantic Version
2.0.0](https://semver.org/) and Cargo rulesets to see if this version
is binary-compatible with the supplied `version`, which can be a string or
version instance itself:

```lua
local version = Version:parse('1.2.3')

-- This is true as 1.2.3 is >= 1.2.0 and < 2.0.0
assert(version:compatible('1.2'))
```

Given an input version below, the following range is allowed:

```
1.2.3  :=  >=1.2.3, <2.0.0
1.2    :=  >=1.2.0, <2.0.0
1      :=  >=1.0.0, <2.0.0
0.2.3  :=  >=0.2.3, <0.3.0
0.2    :=  >=0.2.0, <0.3.0
0.0.3  :=  >=0.0.3, <0.0.4
0.0    :=  >=0.0.0, <0.1.0
0      :=  >=0.0.0, <1.0.0
```

### Converting to string

Converting a version table back into a string is simple and can be done by
calling the `as_string` method or leveraging the metatable method `__tostring`:

```lua
local version = Version:new({ major = 1, minor = 2, patch = 3 })
assert(version:as_string(), '1.2.3')
assert(tostring(version), '1.2.3')
```

### Prerelease

As the prerelease is optional in a semantic version, you can check if it exists
by calling `has_prerelease`, and access the prerelease as a singular string
joined by periods by calling `prerelease_string`.

```lua
local version = Version:parse('1.2.3-alpha.4')
assert(version:has_prerelease())
assert(version:prerelease_string() == 'alpha.4')
```

### Build

As the build is optional in a semantic version, you can check if it exists by
calling `has_build`, and access the build as a singular string joined by
periods by calling `build_string`.

```lua
local version = Version:parse('1.2.3+2023.07.24')
assert(version:has_build())
assert(version:build_string() == '2023.07.24')
```
