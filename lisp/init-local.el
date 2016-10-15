;; Add anything custom here
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)

(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
    Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; make sure these packages are installed
(ensure-package-installed 'evil
                          'evil-tabs
                          'fiplr
                          'twittering-mode
                          'evil-magit
                          'go-mode
                          'beacon
                          'minimap
                          'ace-jump-mode
                          'editorconfig
                          'material-theme
                          'helm)

;; Activate installed packages
(package-initialize)

;; vim keybinding changes
;; Map C-u to scroll up, like in regular vim
(setq evil-want-C-u-scroll t)
;; start evil tabs mode (for :tabnew)
(global-evil-tabs-mode t)
;; Map C-q to Esc (because C-c is already in important prefix
(global-set-key (kbd "C-q") `evil-normal-state)

;; Set tab width to 4
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-width 4)

;; stop creating autosave files
(setq auto-save-default nil)

;; force tab key to actually tab over
(setq-default tab-always-indent nil)

;; enable IDO mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; show line numbers
(global-linum-mode t)

;; bind fiplr to a key combo
(global-set-key (kbd "C-x p") 'fiplr-find-file)

;; add ace-jump-mode key combos
;;(global-set-key (kbd "C-x SPC") 'ace-jump-mode)
;;(global-set-key (kbd "C-x C-x SPC") 'ace-jump-char-mode)

;; emulate vim with escaping via
(defun my-esc (prompt)
  "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
   ;; Key Lookup will use it.
   ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) (kbd "C-q"))
   (t (kbd "C-g"))))

(define-key key-translation-map (kbd "C-c") `my-esc)
;;(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
;;(set-quit-char "C-c")
;; ignore certain directories
(setq fiplr-ignored-globs
      '((directories
         ("node_modules" "bower_components" ".git" "dist" "static"))
        (files ("*.gz" "*.zip" "*.jpg" "*.gif" ".pdf" ".png" "*.woff" "*.svg" ".tff" "*.eot"))))

;; enable copy paste
(setq x-select-enable-clipboard nil)

;; set font to 10pt
(set-face-attribute 'default nil :height 100)

;; enable twitter mode
(require 'twittering-mode)

;; enable editorconfig
(require 'editorconfig)
(editorconfig-mode 1)

;; enable evil magit 
(require 'evil-magit)

;; require and start up in evil mode
(require 'evil)
(evil-mode 1)

(provide 'init-local)
