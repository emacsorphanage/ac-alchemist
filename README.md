# ac-alchemist.el

[auto-complete](https://github.com/auto-complete/auto-complete/) source for [Alchemist](https://github.com/tonini/alchemist.el)

## Sample Configuration

```lisp
(defun my/elixir-mode-hook ()
  (ac-alchemist-setup))

(add-hook 'elixir-mode-hook 'my/elixir-mode-hook)
```
