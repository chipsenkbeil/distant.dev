Stops an active search with the specified `id`.

## Request

```json
{
    "type": "cancel_search",
    "id": 1234
}
```

### Fields

* `id`: the id of the search to cancel. This should match the id received from
  the `search_started` message.

## Response

```json
{
    "type": "ok"
}
```
