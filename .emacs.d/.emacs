(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2)
 '(js2-enter-indents-newline t)
 '(ruby-deep-indent-paren nil)
 '(ruby-deep-indent-paren-style nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ido-mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
(ido-vertical-mode t)
;; show number of lines
(global-linum-mode 1)

;; disable scroll bar
(scroll-bar-mode -1)

;; disable tool bar
(tool-bar-mode -1)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)


(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; dealing with parens
(smartparens-global-mode t)
(require 'smartparens-config)

;;
;;(load "init-smartparens")

;; neotree
(global-set-key [f8] 'neotree-toggle)

;; ace-window for select window quickly
;; use mac command key as super
(setq mac-command-modifier 'super)
(global-set-key (kbd "s-o") 'ace-window)

;; move multiple lines
(global-set-key (kbd "M-n")
                (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "M-p")
                (lambda () (interactive) (previous-line 5)))

;; grep
(global-set-key (kbd "s-f") 'rgrep)

;; js2-mode
(require 'js2-mode)
(add-hook 'js-mode-hook 'js2-mode)
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
(put 'upcase-region 'disabled nil)

;; auto cleanup whitespace
(add-hook 'before-save-hook 'whitespace-cleanup)

(global-set-key (kbd "C-x g") 'magit-status)
