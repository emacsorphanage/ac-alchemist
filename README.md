# ac-alchemist.el

[auto-complete](https://github.com/auto-complete/auto-complete/) source for [Alchemist](https://github.com/tonini/alchemist.el)

## Sample Configuration

```lisp
(defun my/elixir-mode-hook ()
  (auto-complete-mode +1)
  (add-to-list 'ac-sources 'ac-source-alchemist))

(add-hook 'elixir-mode-hook 'my/elixir-mode-hook)
```
