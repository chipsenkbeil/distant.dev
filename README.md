# Requirements

This website uses
[mkdocs-material](https://squidfunk.github.io/mkdocs-material/) on top of
[mkdocs](https://www.mkdocs.org/) to generate itself.

```sh
pip3 install mkdocs-material
```

## Insiders Edition

Note that this site currently uses the Insiders edition, which is a paid
subscription. While it can be built with the normal edition of Mkdocs Material,
some features will be missing or not rendered. The pipeline to re-deploy the
website has access and will use the Insiders edition.

## Macros Plugin

Additionally, we make use of the [macros
plugin](https://mkdocs-macros-plugin.readthedocs.io/en/latest/), which needs to
be installed separately as it is not bundled in with mkdocs-material.

```sh
pip3 install mkdocs-macros-plugin
```

## Optimize Plugin

This plugin comes stock with Mkdocs Material, but we need to install `pngquant`
alongside `pillow` for this to work:

```sh
# For pillow and cairosvg, pip works fine
pip install pillow cairosvg

# For pngquant, we need to use a package manager
brew install pngquant

# For cairosvg, it's also recommended to install dependencies
brew install cairo freetype libffi libjpeg libpng zlib
```

## Distant binary

Finally, we use `distant` to generate help docs that we display on the website.
The latest version needs to be installed as described at
https://distant.dev/getting-started/installation/unix/:

```sh
curl -L https://sh.distant.dev | sh
```

# Building & serving the website

* `mkdocs build` will generate the website locally
* `mkdocs serve` will run a local server with the generated website

Each time a new commit is made on the website, it is re-deployed using
`mkdocs gh-deploy --force`. You do NOT need to deploy it yourself.
