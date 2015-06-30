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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; neotree
(global-set-key [f8] 'neotree-toggle)

(setq mac-command-modifier 'super)

(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'js-mode-hook 'js2-mode)
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
(put 'upcase-region 'disabled nil)
