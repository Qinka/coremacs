;; core/ibuffer

(use-package ibuffer-projectile
  :bind ("C-x C-b" . ibuffer)
  :hook ((ibuffer . ibuffer-auto-mode)
         (ibuffer . ibuffer-projectile-set-filter-groups)
         (ibuffer . (lambda ()
                      (unless (eq ibuffer-sorting-mode 'alphabetic)
                        (ibuffer-do-sort-by-alphabetic)))))
  :config (setq ibuffer-filter-group-name-face 'font-lock-function-name-face))

(provide 'core/ibuffer)
