(require-package 'color-theme-sanityinc-solarized)

(add-hook 'after-init-hook (lambda () (load-theme 'material t)))

(provide 'init-themes)
