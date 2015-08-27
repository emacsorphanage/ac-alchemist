# ac-alchemist.el [![melpa badge][melpa-badge]][melpa-link] [![melpa stable badge][melpa-stable-badge]][melpa-stable-link]

[auto-complete](https://github.com/auto-complete/auto-complete/) source for [Alchemist](https://github.com/tonini/alchemist.el)


## Screenshot

![ac-alchemist](image/ac-alchemist.gif)


## NOTE

**THIS IS EXPERIMENTAL**

alchemist.el frequently changes its interfaces. Please report me if ac-alchemist does not work.
I test only with latest alchemist.el. Please upgrade alchemist.el and test before reporting me.


## Installation

`ac-alchemist` is available on [MELPA](https://melpa.org) and [MELPA-STABLE](https://stable.melpa.org).

You can install `ac-alchemist` with the following command.

<kbd>M-x package-install [RET] ac-alchemist [RET]</kbd>


## Sample Configuration

```lisp
(add-hook 'elixir-mode-hook 'ac-alchemist-setup)
```

[melpa-link]: http://melpa.org/#/ac-alchemist
[melpa-stable-link]: http://stable.melpa.org/#/ac-alchemist
[melpa-badge]: http://melpa.org/packages/ac-alchemist-badge.svg
[melpa-stable-badge]: http://stable.melpa.org/packages/ac-alchemist-badge.svg
