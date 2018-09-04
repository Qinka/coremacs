;; core/ui.el

(eval-when-compile
  (require 'core/const)
  (require 'etc/config))

;; Coremacs
;; Title
(setq frame-title-format
      '("Coremacs (●'◡'●) "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(setq icon-title-format frame-title-format)

(when sys/mac-x-p
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-hook 'after-load-theme-hook
            (lambda ()
              (setcdr (assq 'ns-appearance default-frame-alist)
                      (frame-parameter nil 'background-mode)))))

;; Menu/Tool/Scroll bars
(unless sys/mac-x-p (menu-bar-mode -1))
(and (bound-and-true-p tool-bar-mode) (tool-bar-mode -1))
(and (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(and (bound-and-true-p horizontal-scroll-bar-mode) (horizontal-scroll-bar-mode -1))

;; Theme
(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

;; modeline
(use-package hide-mode-line
  :hook (((completion-list-mode
           completion-in-region-mode
           neotree-mode
           treemacs-mode)
          . hide-mode-line-mode)))

(coremacs-set-theme)

;; Fonts
(use-package cnfonts
  :preface
  ;; Fallback to `all-the-icons'.
  (defun cnfonts--set-all-the-icons-fonts (&optional _)
    "Show icons in all-the-icons."
    (when (featurep 'all-the-icons)
      (dolist (charset '(kana han cjk-misc bopomofo gb18030))
        (dolist (font '("all-the-icons" "github-octicons" "FontAwesome" "Material Icons"))
          (set-fontset-font "fontset-default" charset font nil 'append)))))
  :hook ((after-init . cnfonts-enable)
         (cnfonts-set-font-finish . cnfonts--set-all-the-icons-fonts))
  :config
  ;; NOTE: on macOS, the frame size is changed during the startup without below.
  ;; Keep frame size
  (setq cnfonts-keep-frame-size nil)
  (add-hook 'window-setup-hook
            (lambda ()
              (setq cnfonts-keep-frame-size t)))

  ;; Set profiles
  (setq cnfonts-use-cache t)
  (setq cnfonts-profiles
        '("program-normal" "program-large" "program-small" "org-mode" "read-book"))
  (setq cnfonts--profiles-steps '(("program-normal" . 4)
                                  ("program-large" . 5)
                                  ("program-small" . 3)
                                  ("org-mode" . 6)
                                  ("read-book" . 8))))

;; Line and Column
(setq-default fill-column 80)
(setq column-number-mode t)
(setq line-number-mode t)

;; Show native line numbers if possible, otherwise use linum
(if (fboundp 'display-line-numbers-mode)
    (use-package display-line-numbers
      :ensure nil
      :hook (prog-mode . display-line-numbers-mode))
  (use-package linum-off
    :demand
    :defines linum-format
    :hook (after-init . global-linum-mode)
    :config
    (setq linum-format "%4d ")

    ;; Highlight current line number
    (use-package hlinum
      :defines linum-highlight-in-all-buffersp
      :hook (global-linum-mode . hlinum-activate)
      :init
      (setq linum-highlight-in-all-buffersp t)
      (custom-set-faces
       `(linum-highlight-face
         ((t (:inherit 'default :background ,(face-background 'default) :foreground ,(face-foreground 'default)))))))))

;; Mouse & Smooth Scroll
;; Scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq scroll-step 1
      scroll-margin 0
      scroll-conservatively 100000)

;; Display Time
(use-package time
  :ensure nil
  :unless (display-graphic-p)
  :hook (after-init . display-time-mode)
  :init
  (setq display-time-24hr-format t)
  (setq display-time-day-and-date t))

;; Misc
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(setq visible-bell t)
(size-indication-mode 1)
;; (blink-cursor-mode -1)
(setq track-eol t)                      ; Keep cursor at end of lines. Require line-move-visual is nil.
(setq line-move-visual nil)
(setq inhibit-compacting-font-caches t) ; Don’t compact font caches during GC.

;; Don't open a file in a new frame
(when (boundp 'ns-pop-up-frames)
  (setq ns-pop-up-frames nil))

;; Don't use GTK+ tooltip
(when (boundp 'x-gtk-use-system-tooltips)
  (setq x-gtk-use-system-tooltips nil))

(provide 'core/ui)