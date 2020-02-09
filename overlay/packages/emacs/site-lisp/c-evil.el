(use-package evil
  :ensure t
  :init
  (setq evil-want-C-w-in-emacs-state t
        evil-want-C-u-scroll t
        evil-want-C-d-scroll t)
  :config
  (evil-mode 1)
  (evil-set-leader '(normal motion) (kbd "<SPC>"))
  (evil-define-key '(normal motion) 'global
                   (kbd "<leader><SPC>") 'ido-switch-buffer
                   (kbd "<leader>bb") 'ido-switch-buffer
                   (kbd "<leader>bd") 'kill-buffer ; c-x k
                   (kbd "<leader>fs") 'save-buffer
                   (kbd "<leader>sf") 'find-file
                   (kbd "<leader>da") 'apropos-documentation
                   (kbd "<leader>dv") 'describe-variable
                   (kbd "<leader>df") 'describe-function
                   (kbd "<leader>dk") 'describe-key
                   (kbd "<leader>dm") 'describe-mode
                   (kbd "<leader>ag") 'magit-status
                   (kbd "<leader>as") 'vterm
                   (kbd "<leader>ar") 'ranger-select-files
                   (kbd "<leader>sg") 'fzf-search-git-files
                   (kbd "<leader>sf") 'fzf-search-files
                   (kbd "<leader>sr") 'recentf-ido-find-file
                   (kbd "<leader>ttd") 'switch-dark-theme
                   (kbd "<leader>ttl") 'switch-light-theme
                   (kbd "<leader>tl") 'toggle-truncate-lines
                   (kbd "<leader>tm") 'toggle-menu-bar)
  ;(dotimes (x 9)
  ;  (evil-define-key '(normal motion visual) 'global
  ;    (kbd (format "<leader>%d" (+ 1 x)))
  ;    `(lambda ()
  ;      (interactive)
  ;      (select-window-by-index ,x))
  (define-key evil-window-map [backspace] 'evil-window-left)
  (define-key evil-window-map (kbd "C-l") 'evil-window-right)
  (define-key evil-window-map (kbd "C-j") 'evil-window-bottom)
  (define-key evil-window-map (kbd "C-k") 'evil-window-top)
  (dolist (mode (list emacs-lisp-mode-map
                      lisp-interaction-mode-map))
    (evil-define-key '(normal motion) mode
                     (kbd ",e") 'eval-buffer
                     (kbd ",l") 'eval-last-sexp))
  (evil-define-key '(normal motion) 'parinfer-mode
                   (kbd ",p") 'parinfer-toggle-mode))

(provide 'c-evil)
