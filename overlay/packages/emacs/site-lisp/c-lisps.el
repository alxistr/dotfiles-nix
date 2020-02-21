(require 'clojure-mode)
(require 'cider)

;; todo coercing
;; todo fennel

(defvar lisp-modes (list 'clojure-mode-hook
                         'emacs-lisp-mode-hook
                         'common-lisp-mode-hook
                         'scheme-mode-hook
                         'hy-mode-hook
                         'lisp-mode-hook
                         'lisp-interaction-mode-hook))

(use-package hy-mode
  :mode "\\.hy\\'")

(use-package parinfer-rust-mode
  ;:ensure t
  :config
  (dolist (hook lisp-modes)
    (add-hook hook #'parinfer-rust-mode))
  (dolist (mode (list cider-repl-mode-map))
    (evil-define-key '(normal motion) mode
      (kbd ",/") 'cider-switch-to-last-clojure-buffer
      (kbd ",f") 'cider-find-var
      (kbd ",d") 'cider-doc
      (kbd ",q") 'cider-quit))
  (dolist (mode (list clojure-mode-map
                      clojurec-mode-map
                      clojurescript-mode-map))
    (evil-define-key '(visual) mode
      (kbd ",,") 'cider-eval-region)
    (evil-define-key '(normal motion) mode
      (kbd ",,") 'cider-eval-defun-at-point
      (kbd ",I") 'cider-jack-in
      (kbd ",f") 'cider-find-var
      (kbd ",d") 'cider-doc
      (kbd ",/") 'cider-switch-to-repl-buffer))
  (dolist (mode (list emacs-lisp-mode-map
                      lisp-interaction-mode-map))
    (evil-define-key '(normal motion) mode
      (kbd ",e") 'eval-buffer
      (kbd ",l") 'eval-last-sexp)))

(provide 'c-lisps)
