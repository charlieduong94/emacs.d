(require-package 'color-theme-sanityinc-solarized)

(add-hook 'after-init-hook (lambda () (load-theme 'solarized-dark)))

(provide 'init-themes)
