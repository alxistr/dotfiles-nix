(use-package evil
  :ensure t
  :init
  (setq evil-want-C-w-in-emacs-state t
        evil-want-C-u-scroll t
        evil-want-C-d-scroll t)
  :config
  (evil-mode 1)
  (evil-set-leader '(normal motion visual) (kbd "<SPC>"))
  (evil-define-key '(normal motion) 'global
                   (kbd "<leader>i") 'start-search-for-symbol
                   (kbd "<leader><SPC>") 'ido-switch-buffer
                   (kbd "<leader>bb") 'ido-switch-buffer
                   (kbd "<leader>bm") 'buffer-menu
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
                   (kbd "<leader>ts") 'speedup-large-file
                   (kbd "<leader>tm") 'toggle-menu-bar)
  (evil-define-key '(visual) 'global
    (kbd "<leader>i") 'start-search-for-region)
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
  nil)

(use-package evil-magit)

(defun start-search-for (string forward)
  (let* ((search-symbol (if evil-regexp-search 'regexp-search-ring 'search-ring))
         (old-value (or (and (boundp search-symbol) (symbol-value search-symbol))
                        '()))
         (new-value (cons string old-value)))
    (message "sl %s" new-value)
    (set search-symbol new-value))
  (evil-search string forward))

(defun start-search-for-symbol ()
  (interactive)
  (let ((string (thing-at-point 'symbol))
        (forward t))
    (start-search-for string forward)))

(defun start-search-for-region ()
  (interactive)
  (let ((string (buffer-substring (region-beginning) (region-end)))
        (forward t))
    (start-search-for string forward)))

(defun speedup-large-file ()
  (interactive)
  (linum-mode 0)
  (whitespace-mode 0))

;(global-set-key (kbd "C-S-V") #'paste-from-clipboard)

(provide 'c-evil)
