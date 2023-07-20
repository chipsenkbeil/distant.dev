Out of the box, the distant plugin provides file navigation with a similar
experience to [netrw](https://www.vim.org/scripts/script.php?script_id=1075).
You can modify or disable entirely these bindings by [configuring them during
setup](../setup/keymap).

## Within a file

| Key | Action                                            |
| --- | ------------------------------------------------- |
| `-` | Opens up the parent directory of the current file |

## Within a directory

| Key         | Action                                                       |
| ----------  | ------------------------------------------------------------ |
| `<Return>`  | Opens the file or directory under the cursor                 |
| `-`         | Opens up the parent directory of the current directory       |
| `<Shift-K>` | Creates a new directory within the current directory         |
| `<Shift-N>` | Creates a new file within the current directory              |
| `<Shift-R>` | Renames the file or directory under the cursor               |
| `<Shift-D>` | Removes the file or directory under the cursor               |
| `<Shift-M>` | Displays metadata for the file or directory under the cursor |
| `<Shift-C>` | Copies the file or directory under the cursor                |
