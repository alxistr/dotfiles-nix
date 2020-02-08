(use-package hy-mode
  :mode "\\.hy\\'")

;; todo coercing
;; todo fennel

(use-package parinfer
  :ensure t
  :init
  (setq parinfer-extensions
        '(defaults
          evil
          ;lispy
          ;paredit
          ;smart-tab
          smart-yank))
  :config
  (parinfer-toggle-mode)
  (add-hook 'clojure-mode-hook #'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  (add-hook 'common-lisp-mode-hook #'parinfer-mode)
  (add-hook 'scheme-mode-hook #'parinfer-mode)
  (add-hook 'hy-mode-hook #'parinfer-mode)
  (add-hook 'lisp-mode-hook #'parinfer-mode)
  (add-hook 'lisp-interaction-mode-hook #'parinfer-mode))

(provide 'c-lisps)
