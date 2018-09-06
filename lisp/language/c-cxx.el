;; language/c-c++.el

(eval-when-compile
  (require 'etc/config))

;; C/C++ Mode
(use-package cc-mode
  :defer t
  :ensure nil
  :bind (:map c-mode-base-map
              ("C-c c" . compile))
  :hook (c-mode-common . (lambda ()
                           (c-set-style "k&r")
                           (setq tab-width 4)
                           (setq c-basic-offset 4)))
  :config
  (unless coremacs-lsp
    (use-package irony
      :defines (irony-mode-map irony-server-w32-pipe-buffer-size)
      :hook (((c-mode c++-mode objc-mode) . irony-mode)
             (irony-mode . irony-cdb-autosetup-compile-options))
      :config
      ;; Windows performance tweaks
      (when (boundp 'w32-pipe-read-delay)
        (setq w32-pipe-read-delay 0))
      ;; Set the buffer size to 64K on Windows (from the original 4K)
      (when (boundp 'w32-pipe-buffer-size)
        (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

      (with-eval-after-load 'counsel
        (bind-keys :map irony-mode-map
                   ([remap completion-at-point] . counsel-irony)
                   ([remap complete-symbol] . counsel-irony)))

      (use-package irony-eldoc
        :hook (irony-mode . irony-eldoc))

      (with-eval-after-load 'company
        (use-package company-irony
          :init (cl-pushnew (company-backend-with-yas 'company-irony) company-backends))
        (use-package company-irony-c-headers
          :init (cl-pushnew (company-backend-with-yas 'company-irony-c-headers) company-backends)))

      (with-eval-after-load 'flycheck
        (use-package flycheck-irony
          :hook (flycheck-mode . flycheck-irony-setup))))

    ;; Company mode backend for C/C++ header files
    (with-eval-after-load 'company
      (use-package company-c-headers
        :functions company-backend-with-yas
        :init (cl-pushnew (company-backend-with-yas 'company-c-headers) company-backends)))))


(provide 'language/c-cxx)
