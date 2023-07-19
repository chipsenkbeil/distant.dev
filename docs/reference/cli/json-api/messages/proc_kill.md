Kill a running process with the distant-specific `id`.

## Request

```json
{
    "type": "proc_kill",
    "id": 1234
}
```

### Fields

* `id`: the id of the process to kill, which should match the `id` received
  from the `proc_spawned` message.

## Response

```json
{
    "type": "ok"
}
```
