Sends bytes to the *stdin* of a running process with the distant-specific `id`.

## Request

```json
{
    "type": "proc_stdin",
    "id": 1234,
    "data": []
}
```

### Fields

* `id`: the id of the process, which should match the `id` received from the
  `proc_spawned` message.

* `data`: byte array representing the data to send to the *stdin* of the
  process.

## Response

```json
{
    "type": "ok"
}
```
