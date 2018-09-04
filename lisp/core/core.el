;; core/core.el

(eval-when-compile
  (require 'core/const)
  (require 'etc/config))

;; Personal information
(setq user-full-name coremacs-full-name)
(setq user-mail-address coremacs-mail-address)

;; Configure the system
(when sys/win32p
  ;; make PC keyboard's Win key or other to type Super or Hyper
  (setq w32-lwindow-modifier 'super)    ; Left Windows key
  (setq w32-apps-modifier    'hyper)    ; Menu/App key
  ;; (w32-register-hot-key [s-])
  (w32-register-hot-key [s-t]))

(when (or sys/mac-x-p sys/linux-x-p)
  (use-package exec-path-from-shell
    :init
    (setq exec-path-from-shell-check-startup-files nil)
    (setq exec-path-from-shell-variables          '("PATH" "MANPATH" "PYTHONPATH" "GOPATH"))
    (setq exec-path-from-shell-arguments          '("-l"))
    (exec-path-from-shell-initialize)))

;; Start server
(use-package server
  :ensure nil
  :hook (after-init . server-mode))

;; History
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(use-package recentf
  :ensure nil
  ;; lazy load recentf
  :hook (find-file . (lambda () (unless recentf-mode
                             (recentf-mode)
                             (recentf-track-opened-file))))
  :init
  ;; (add-hook 'after-init-hook #'recentf-mode)
  (setq recentf-max-saved-items 200)
  :config
  (add-to-list 'recentf-exclude (expand-file-name package-user-dir))
  (add-to-list 'recentf-exclude ".cache")
  (add-to-list 'recentf-exclude ".cask")
  (add-to-list 'recentf-exclude "bookmarks")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'"))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 60))

(provide 'core/core)