;; language/gpu.el

(use-package cuda-mode
    :defer t)

(use-package opencl-mode
    :defer t
    :mode (("\\.cl\\'" . opencl-mode)))

(provide 'language/gpu)