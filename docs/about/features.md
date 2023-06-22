Distant supports multiple backends to facilitate remote communication with
another server. Today, these backends include:

* **distant:** a standalone server acting as the reference implementation.
* **ssh:** a wrapper around an ssh client that translates the distant protocol
  into ssh server requests.

Not every backend supports every feature of distant. Below is a table outlining
the available features and which backend supports each feature:

| Feature               | distant | ssh |
| --------------------- | --------| ----|
| Filesystem I/O        | ✅      | ✅  |
| Filesystem Watching   | ✅      | ❌  |
| Process Execution     | ✅      | ✅  |
| Reconnect             | ✅      | ❌  |
| Search                | ✅      | ❌  |
| System Information    | ✅      | ⚠   |

* ✅ means full support
* ⚠ means partial support
* ❌ means no support

### Feature Details

* **Filesystem I/O:** able to read from and write to the filesystem
* **Filesystem Watching:** able to receive notifications when changes to the
  filesystem occur
* **Process Execution:** able to execute processes
* **Reconnect:** able to reconnect after network outages
* **Search:** able to search the filesystem
* **System Information:** able to retrieve information about the system
