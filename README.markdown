# rack-pygmoku

`Rack::Pygmoku` is a middleware for generating code syntax highlighting using the
[Pygments](http://pygments.org/) library in an environment where you cannot
install Pygments directly.

In other words, it's ideal for use on Heroku.

## Usage

First, of course, install the gem.

Currently, `rack-pygmoku` only supports Markdown-style code blocks, like
so:

    <pre data-lang='ruby'>
      <code>
        def greeting
          'Hello World!'
        end
      </code>
    </pre>

_Note:_ Put the short name of the
[Pygments lexer](http://pygments.org/docs/lexers/) that you want to use in the
`data-lang` or `data-lexer` attribute on the `pre` block.

## Status

This is mainly a _toy project_ that I put together for my Nesta-powered
blog, and is likely to be maintained as such unless others find it
useful.

## Copyright

Copyright (c) 2011 Kevin Rohrbaugh.

See LICENSE.txt for further details.

