;; etc/config.el

(eval-when-compile
  (require 'core/const))

(defcustom coremacs-benchmark nil
  "Enable the init benchmark or not."
  :type 'boolean)


(defcustom coremacs-full-name "Joahnn Lee"
  "Set user full name."
  :type 'string)

(defcustom coremacs-mail-address "me@qinka.pro"
  "Set user email address."
  :type 'string)

(defun coremacs-set-theme ()
  ;;   (use-package monokai-theme
  ;;     :init (load-theme 'monokai t)))
  (use-package spacemacs-theme
    :init (load-theme 'spacemacs-dark t)))
;;   (use-package spacemacs-theme
;;     :init (load-theme 'spacemacs-light t)))
;;   (use-package leuven-theme
;;     :init (load-theme 'leuven t)))


(defcustom coremacs-company-enable-yas t
  "Enable yasnippet for company backends or not."
  :type 'boolean)

(defcustom coremacs-lsp t
  "Enable language servers or not."
  :type 'boolean)



(provide 'etc/config)
