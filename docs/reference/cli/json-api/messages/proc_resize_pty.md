Resizes the pseudo-terminal of a running process with the distant-specific
`id`.

## Request

```json
{
    "type": "proc_resize_pty",
    "id": 1234,
    "size": {
        "rows": 80,
        "cols": 24,
        "pixel_width": 0,
        "pixel_height": 0
    }
}
```

### Fields

* `id`: the id of the process, which should match the `id` received from the
  `proc_spawned` message.

* `size`: object defining the new size for an existing pseudo-terminal tied to
  the process.

    * `rows`: number of rows (lines) for the pty.
    * `cols`: number of columns for the pty.
    * `pixel_width`: (optional) width of a cell in pixels. Note that some
      systems never fill this value and ignore it.
    * `pixel_height`: (optional) height of a cell in pixels. Note that some
      systems never fill this value and ignore it.

## Response

```json
{
    "type": "ok"
}
```
