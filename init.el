(message "Coremacs enabled")

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold 30000000)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after init."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold 800000)
            (add-hook 'focus-out-hook 'garbage-collect)))

;; Load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; config
(require 'etc/config)
;; coremacs modules
(require 'core/const)
(require 'core/package)
(require 'core/core)
(require 'core/utility)
(require 'core/ui)
(require 'core/editor)
(require 'core/ivy)
(require 'core/yasnippet)
(require 'core/company)
(require 'core/treemacs)
(require 'core/window)
(require 'core/kill-ring)
(require 'core/ibuffer)
(require 'core/hightlight)
(require 'core/dired)



;; load configured modules
(require 'etc/load)

