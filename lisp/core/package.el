;; core/package.el

(eval-when-compile
  (require 'core/const)
  (require 'etc/config))

;; FIXME: DO NOT copy package-selected-packages to init/custom file forcibly.
;; https://github.com/jwiegley/use-package/issues/383#issuecomment-247801751
;; Prevent change init.el
(defun my-save-selected-packages (&optional value)
  "Set and (don't!) save `package-selected-packages' to VALUE."
  (when value
    (setq package-selected-packages value))
  (unless after-init-time
    (add-hook 'after-init-hook #'package--save-selected-packages)))

(advice-add 'package--save-selected-packages :override #'my-save-selected-packages)

;; package archives
(setq package-archives    '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                            ("org"   . "http://elpa.emacs-china.org/org/")
                            ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; initialize package
(setq package-enable-at-startup nil)
(package-initialize)

;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Should set before loading `use-package'
(setq use-package-always-ensure        t)
(setq use-package-always-defer         t)
(setq use-package-expand-minimally     t)
(setq use-package-enable-imenu-support t)

(eval-when-compile
  (require 'use-package))

;; Required by `use-package'
(use-package diminish)
(use-package bind-key)

;; enable benchmark
(when coremacs-benchmark
  (use-package benchmark-init
    :commands (benchmark-init/activate)
    :hook     (after-init . benchmark-init/deactivate)
    :init     (benchmark-init/activate)))

;; Extensions
(use-package package-utils
  :init
  (defalias 'upgrade-packages 'package-utils-upgrade-all)
  (defalias 'upgrade-packages-and-restart 'package-utils-upgrade-all-and-restart))

(provide 'core/package)
;;; END OF CORE/PACKAGE