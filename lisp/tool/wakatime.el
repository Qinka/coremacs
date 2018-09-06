;; tool/wakatime.el

(use-package wakatime-mode
    :defer t
    :init
    (add-hook 'prog-mode-hook 'wakatime-mode)
    :config
    (setq wakatime-api-key  "537f1330-b032-425a-ba86-7e8280074df3"
          wakatime-cli-path "c:/Users/qinka/AppData/Local/Programs/Python/Python36/Scripts/wakatime"))


(provide 'tool/wakatime)