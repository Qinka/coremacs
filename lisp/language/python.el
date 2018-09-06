;; language/python.el


(eval-when-compile
  (require 'core/const)
  (require 'etc/config))

;; Python Mode
(use-package python
  :ensure nil
  :defines gud-pdb-command-name pdb-path
  :config
  ;; Disable readline based native completion
  (setq python-shell-completion-native-enable nil)

  (add-hook 'inferior-python-mode-hook
            (lambda ()
              (bind-key "C-c C-z" #'kill-buffer-and-window inferior-python-mode-map)
              (process-query-on-exit-flag (get-process "Python"))))

  ;; Pdb setup, note the python version
  (setq pdb-path 'pdb
        gud-pdb-command-name (symbol-name pdb-path))
  (defadvice pdb (before gud-query-cmdline activate)
    "Provide a better default command line when called interactively."
    (interactive
     (list (gud-query-cmdline
            pdb-path
            (file-name-nondirectory buffer-file-name)))))

  ;; Autopep8
  (use-package py-autopep8
    :hook (python-mode . py-autopep8-enable-on-save))

  ;; Anaconda mode
  (unless coremacs-lsp
    (use-package anaconda-mode
      :defines anaconda-mode-localhost-address
      :diminish anaconda-mode
      :hook ((python-mode . anaconda-mode)
             (python-mode . anaconda-eldoc-mode))
      :config
      ;; Workaround: https://github.com/proofit404/anaconda-mode#faq
      (when sys/macp
        (setq anaconda-mode-localhost-address "localhost"))
      (use-package company-anaconda
        :after company
        :defines company-backends
        :functions company-backend-with-yas
        :init (cl-pushnew (company-backend-with-yas 'company-anaconda) company-backends)))))


(provide 'language/python)
