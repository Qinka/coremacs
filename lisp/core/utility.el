;; core/utility.el

(eval-when-compile
  (require 'core/const)
  (require 'etc/config))

;; Dos2Unix/Unix2Dos
(defun dos2unix ()
  "Convert the current buffer to UNIX file format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

(defun unix2dos ()
  "Convert the current buffer to DOS file format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))

;; Revert buffer
(defun revert-current-buffer ()
  "Revert the current buffer."
  (interactive)
  (message "Revert this buffer.")
  (revert-buffer t t))
(bind-keys ("<f5>" . revert-current-buffer)
           ("s-r"  . revert-current-buffer))

;; reload
(defun reload-config ()
  "Reload the init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; Update
(defun update-config ()
  "Update Emacs configurations to the latest version."
  (interactive)
  (let ((dir (expand-file-name "~/.emacs.d/")))
    (if (file-exists-p dir)
        (progn
          (message "Updating Emacs configurations...")
          (cd dir)
          (shell-command "git pull")
          (message "Update finished. Restart Emacs to complete the process."))
      (message "\"%s\" doesn't exist." dir))))

(declare-function upgrade-packages             'core/package)
(declare-function upgrade-packages-and-restart 'core/package)

(defun update-coremacs()
  "Update confgiurations and packages."
  (interactive)
  (update-config)
  (upgrade-packages))

(defun update-coremacs-and-restart ()
  "Update configurations and packages, then restart."
  (interactive)
  (update-config)
  (upgrade-packages-and-restart))

;; Create a new scratch buffer
(defun create-scratch-buffer ()
  "Create a scratch buffer."
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode))

;; Save a file as utf-8
(defun save-buffer-as-utf8 (coding-system)
  "Revert a buffer with `CODING-SYSTEM' and save as UTF-8."
  (interactive "zCoding system for visited file (default nil):")
  (revert-buffer-with-coding-system coding-system)
  (set-buffer-file-coding-system 'utf-8)
  (save-buffer))

;; Recompile elpa directory
(defun recompile-elpa ()
  "Recompile packages in elpa directory. Useful if you switch Emacs versions."
  (interactive)
  (byte-recompile-directory package-user-dir nil t))

;; Recompile site-lisp directory
(defun recompile-site-lisp ()
  "Recompile packages in site-lisp directory."
  (interactive)
  (byte-recompile-directory
   (concat user-emacs-directory "site-lisp") 0 t))

(provide 'core/utility)