;; todo coercing
;; todo fennel

(defvar lisp-modes (list 'clojure-mode-hook
                         'clojurec-mode-hook
                         'clojurescript-mode-hook
                         'emacs-lisp-mode-hook
                         'lisp-interaction-mode-hook
                         'common-lisp-mode-hook
                         'scheme-mode-hook
                         'hy-mode-hook
                         'lisp-mode-hook
                         'lisp-interaction-mode-hook))

(use-package hy-mode
  :mode "\\.hy\\'")

(use-package clojure-mode)

(use-package cider
  :init
  (setq nrepl-log-messages t))

(use-package parinfer-rust-mode)

(use-package origami
  :config
  (evil-define-key '(normal motion) 'global
    (kbd "<leader>oo") 'origami-show-only-node
    (kbd "<leader>oc") 'origami-close-all-nodes
    (kbd "<leader>os") 'origami-open-all-nodes
    (kbd "<leader>ot") 'origami-toggle-node))

(dolist (hook lisp-modes)
  (add-hook hook #'origami-mode)
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
    (kbd ",,") 'cider-eval-region
    (kbd ",l") 'cider-eval-region)
  (evil-define-key '(normal motion) mode
    (kbd ",,")  'cider-eval-sexp-at-point
    (kbd ",l")  'cider-eval-last-sexp
    (kbd ",ee") 'cider-eval-defun-at-point
    (kbd ",eb") 'cider-eval-buffer
    (kbd ",ep") 'cider-pprint-eval-defun-at-point
    (kbd ",cI") 'cider-jack-in
    (kbd ",cc") 'cider-describe-connection
    (kbd ",f")  'cider-find-var
    (kbd ",d")  'cider-doc
    (kbd ",/")  'cider-switch-to-repl-buffer))

(dolist (mode (list emacs-lisp-mode-map
                    lisp-interaction-mode-map))
  (evil-define-key '(normal motion) mode
    (kbd ",f")  'xref-find-definitions
    (kbd ",e")  'eval-buffer
    (kbd ",l")  'eval-last-sexp))

(provide 'c-lisps)
