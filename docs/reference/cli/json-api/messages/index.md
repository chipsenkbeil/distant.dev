When using the [API command](/reference/cli/commands/api/), messages can be
sent between the client and server using the [JSON lines text
format](https://jsonlines.org/). This means that all JSON messages are sent
where each line is a valid JSON message and the line separator is `\n`.

## Message format

All messages contain at least two fields:

* `id`: string representing a unique id associated with the message.
* `payload`: arbitrary payload tied to the message.

```json
{
    "id": "...",
    "payload": ???
}
```

In the case of responses, there is an additional field:

* `origin_id`: string matching the `id` of the request that led to this
  response. More than one response can be sent for the same request, and each
  of those responses will have the same `origin_id`.

```json
{
    "id": "...",
    "origin_id": "...",
    "payload": ???
}
```

In addition to specific fields, requests and responses can both have an
optional `headers` field, which is an object of key-value pairs. The use of
this field is optional, can be missing from requests and responses, and can be
handled differently in each implementation of distant's protocol.

### Payload format

The payload represents the actual data associated with a request or response.
This can come in one of two formats:

* *object*: if the message represents a singular request or response, the
  payload will be an object with a `type` field and zero or more additional
  fields associated with the particular request/response.

    ```json
    {
        "type": "..."
    }
    ```

* *array*: if the message represents multiple requests or responses, the
  payload will be an array of objects, each with a `type` field and zero or
  more additional fields associated with the particular request/response.

    ```json
    [
        {
            "type": "..."
        }
    ]
    ```

### Batch requests

When sending multiple requests, they can be bundled in a singular JSON object
by adding them as payload array. As a result, servers are expected to process
these requests concurrently and send back a singular result object with a
payload array in the same order as the requests.

```json
{
    "id": "...",
    "payload": [{ "type": "..." }, { "type": "..." }]
}
```

If requests need to be processed in order, such as writing a file and reading
its metadata, the request header can include `sequence` with the value `true`.
This indicates to the server that the payload of requests should be processed
sequentially, meaning that the first payload request should be completed before
the next is started.

```json
{
    "headers": { "sequence": "true" },
    "id": "...",
    "payload": [{ "type": "..." }, { "type": "..." }]
}
```

!!! note

    When processing sequentially, if a request fails, all subsequent requests
    in the payload will be canceled and an error will be returned in each of
    their places.

## Errors

If an error is encountered while processing a request, the error will be
captured and encoded in an `error` response. The payload representing a single
error is as follows:

```json
{
    "type": "error",
    "kind": "",
    "description": "..."
}
```

### Kinds of errors

This is a non-exhaustive list of the kinds of errors that can be encountered.
These mirror Rust's
[`std::io::ErrorKind`](https://doc.rust-lang.org/std/io/enum.ErrorKind.html).
Typically, the kind will be `other` unless one of the other types fits such as
`not_found` for reading a file.

| Kind                   | Description                                                                                                  |
| ------------------     | ------------------------------------------------------------------------------------------------------------ |
| **addr_in_use**        | a socket address could not be bound because the address is already in use elsewhere.                         |
| **addr_not_available** | a nonexistent interface was requested or the requested address was not local.                                |
| **already_exists**     | an entity already exists, often a file.                                                                      |
| **broken_pipe**        | the operation failed because a pipe was closed.                                                              |
| **connection_aborted** | the connection was aborted (terminated) by the remote server.                                                |
| **connection_refused** | the connection was refused by the remote server.                                                             |
| **connection_reset**   | the connection was reset by the remote server.                                                               |
| **interrupted**        | this operation was interrupted.                                                                              |
| **invalid_data**       | data not valid for the operation were encountered.                                                           |
| **invalid_input**      | a parameter was incorrect.                                                                                   |
| **loop**               | when a loop is encountered when walking a directory.                                                         |
| **not_connected**      | the network operation failed because it was not connected yet.                                               |
| **not_found**          | an entity was not found, often a file.                                                                       |
| **other**              | any I/O error not part of this list.                                                                         |
| **out_of_memory**      | an operation could not be completed, because it failed to allocate enough memory.                            |
| **permission_denied**  | the operation lacked the necessary privileges to complete.                                                   |
| **task_cancelled**     | when a task is cancelled.                                                                                    |
| **task_panicked**      | when a task panics.                                                                                          |
| **timed_out**          | the I/O operation's timeout expired, causing it to be cancelled.                                             |
| **unexpected_eof**     | an error returned when an operation could not be completed because an "end of file" was reached prematurely. |
| **unknown**            | catchall for an error that has no specific type.                                                             |
| **unsupported**        | this operation is unsupported on this platform.                                                              |
| **would_block**        | the operation needs to block to complete, but the blocking operation was requested to not occur.             |
| **write_zero**         | an error returned when an operation could not be completed because a call to `write` returned `Ok(0)`.       |
