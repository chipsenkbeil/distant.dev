Distant supports multiple backends to facilitate remote communication with
another server. Today, these backends include:

* **distant:** a standalone server acting as the reference implementation.
* **ssh:** a wrapper around an ssh client that translates the distant protocol
  into ssh server requests.

Not every backend supports every feature of distant. Below is a table outlining
the available features and which backend supports each feature:

| Feature                  | distant      | ssh             |
| ------------------------ | ------------ | --------------- |
| Filesystem I/O      [^1] | {{ f_full }} | {{ f_full }}    |
| Filesystem Watching [^2] | {{ f_full }} | {{ f_none }}    |
| Process Execution   [^3] | {{ f_full }} | {{ f_full }}    |
| Reconnect           [^4] | {{ f_full }} | {{ f_none }}    |
| Search              [^5] | {{ f_full }} | {{ f_none }}    |
| System Information  [^6] | {{ f_full }} | {{ f_partial }} |

[^1]: able to read from and write to the filesystem.
[^2]: able to receive notifications when changes to the filesystem occur.
[^3]: able to execute processes.
[^4]: able to reconnect after network outages.
[^5]: able to search the filesystem.
[^6]: able to retrieve information about the system.
