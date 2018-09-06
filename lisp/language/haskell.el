;; language/haskell.el

(use-package haskell-mode
  :defer t
  :mode "\\.l?c?hsc?$"
  :mode ("\\.cabal$" . haskell-cabal-mode)
  :interpreter (("runghc" . haskell-mode)
                ("runhaskell" . haskell-mode))
  :init
  (progn (setq haskell-mode-hook nil)
         (add-hook 'haskell-mode-hook #'haskell-indentation-mode)
         (add-hook 'haskell-mode-hook #'interactive-haskell-mode))
  :config
  (load "haskell-mode-autoloads" nil t)
  (push ".hi" completion-ignored-extensions))


(use-package intero
  :defer t
  :hook (haskell-mode . intero-mode)
  :config
  (unless (executable-find "stack")
    (warn "haskell-mode: couldn't find stack, disabling intero")
    (remove-hook 'haskell-mode-hook #'intero-mode))
  (add-hook 'intero-mode-hook #'flycheck-mode)
  (add-hook 'intero-mode-hook #'flycheck-mode))

(use-package company-cabal
  :defer t
  :after haskell-cabal-mod
  :init
  (push '(company-cabal)
        company-backends-haskell-cabal-mode))


(provide 'language/haskell)
