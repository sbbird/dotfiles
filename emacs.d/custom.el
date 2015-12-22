(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 2)
 '(js2-enter-indents-newline t)
 '(ruby-deep-indent-paren nil)
 '(ruby-deep-indent-paren-style nil)
 '(scroll-bar-mode nil))

;; neotree
;;(global-set-key [f8] 'neotree-toggle)

(setq mac-command-modifier 'super)

(put 'upcase-region 'disabled nil)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "M-p") 'ace-window)

;; in ubuntu, js2-mode only bind newline-and-indent on C-j but not RET
(add-hook 'js2-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

(add-hook 'before-save-hook 'whitespace-cleanup)

(setq prelude-whitespace nil)
