;; language/html.el

(use-package company-web)

(use-package css-mode
    :defer t
    :init
    (progn
      (push 'company-css company-backends-css-mode)

      ;; Mark `css-indent-offset' as safe-local variable
      (put 'css-indent-offset 'safe-local-variable #'integerp)))

(use-package emmet-mode
    :defer t
    :init
    (add-hooks 'css-mode-hook 'emmet-mode)
    (add-hooks 'html-mode-hook 'emmet-mode))

(provide 'language/html)