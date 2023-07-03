# Requirements

This website uses
[mkdocs-material](https://squidfunk.github.io/mkdocs-material/) on top of
[mkdocs](https://www.mkdocs.org/) to generate itself.

```sh
pip3 install mkdocs-material
```

Additionally, we make use of the [macros
plugin](https://mkdocs-macros-plugin.readthedocs.io/en/latest/), which needs to
be installed separately as it is not bundled in with mkdocs-material.

```sh
pip3 install mkdocs-macros-plugin
```

# Building & serving the website

* `mkdocs build` will generate the website locally
* `mkdocs serve` will run a local server with the generated website

Each time a new commit is made on the website, it is re-deployed using
`mkdocs gh-deploy --force`. You do NOT need to deploy it yourself.
