;; tool/vcs.el

(eval-when-compile
  (require 'core/const))

;; Git
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)
         ("C-c M-g" . magit-file-popup))
  :config
  (when sys/win32p
    (setenv "GIT_ASKPASS" "git-gui--askpass")))

;; Github integration
(use-package magithub
  :init
  (setq magithub-api-timeout 5)
  (magithub-feature-autoinject t))

;; Gitflow externsion for Magit
(use-package magit-gitflow
  :diminish magit-gitflow-mode
  :functions magit-define-popup-action
  :bind (:map magit-status-mode-map
              ("G" . magit-gitflow-popup))
  :hook (magit-mode . turn-on-magit-gitflow)
  :config
  (magit-define-popup-action 'magit-dispatch-popup
                             ?G "GitFlow" #'magit-gitflow-popup ?!))

;; Git-Svn extension for Magit
(use-package magit-svn
  :diminish magit-svn-mode
  :hook (magit-mode . magit-svn-mode))

;;; Pop up last commit information of current line
(use-package git-messenger
  :commands git-messenger:copy-message
  :bind (:map vc-prefix-map
              ("p" . git-messenger:popup-message)
              :map git-messenger-map
              ("m" . git-messenger:copy-message))
  :init
  ;; Use magit-show-commit for showing status/diff commands
  (setq git-messenger:use-magit-popup t))

;; Walk through git revisions of a file
(use-package git-timemachine
  :bind (:map vc-prefix-map
              ("t" . git-timemachine)))

;; Highlighting regions by last updated time
(use-package smeargle
  :bind (:map vc-prefix-map
              ("S" . smeargle)
              ("C" . smeargle-commits)
              ("R" . smeargle-clear)))

;; Git modes
(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)

;; Open github/gitlab/bitbucket page
(use-package browse-at-remote)

(provide 'tool/vcs)
