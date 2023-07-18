# Introduction

```
mkdir -p ~/.config/nvim
mkdir -p ~/projects/tree-sitter-zimbu
```

Copy `init.lua` to `~/.config/nvim/`.

Open `nvim`. It starts installing messages and language servers.

### Goodies

`<space> sf`: search for a name

Auto completion movement using `<ctrl> p` (previous) and
`<ctrl> n` (next).

Move to quick fix list: ??? TODO

`gd` for Go To Definition, `gr` for Go To References. Can fuzzy
find in references.

`:Telescope keymaps` shows all key shortcuts.

`<space> ws` for workspace symbols, `<space> ds` for document
symbols.

`:Mason` install language servers, `i` to accept it.

`:Telescope helptags`, has fzf search.

`<space>?` find recently opened files.

`<space><space>` find existing buffers.

`<space>/` try it out document here

`:Telescope builtin` to get all possible actions

`<ctrl><space>` select a bigger section

### Uninstall

```
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy
rm -rf ~/.config/nvim/lazy-lock.json
```
