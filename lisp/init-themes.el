(require-package 'color-theme-sanityinc-solarized)

(add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-solarized-dark)))

(provide 'init-themes)
