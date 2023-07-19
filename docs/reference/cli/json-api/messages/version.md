Retrieves version information about the server and protocol.

## Request

```json
{
    "type": "version"
}
```

## Response

```json
{
    "type": "version",
    "server_version": "0.20.0",
    "protocol_version": "0.20.0",
    "capabilities": []
}
```

### Fields

* `server_version`: string representing the version of the server following
  [Semantic Versioning](https://semver.org/).

* `protocol_version`: string representing the version of the network protocol
  (messages and authentication) following [Semantic
  Versioning](https://semver.org/). Note that this can be different from the
  server version as the protocol stabilizes.

* `capabilities`: array of strings representing the capabilities of the server
  when it comes to implementation of the protocol. As of version `0.20`, there
  are the following capabilities possible:

    * `exec`: supports executing processes.
    * `fs_io`: supports performing I/O operations on the filesystem.
    * `fs_perm`: supports modifying permissions on the filesystem.
    * `fs_search`: supports searching the filesystem.
    * `fs_watch`: supports watching the filesystem for changes.
    * `sys_info`: supports retrieving system information.

### Notes

* It is expected that the reference implementation of distant implements all
  capabilities. For those that do not implement a capability, associated
  requests should respond with an error of the `kind` *unsupported*.
