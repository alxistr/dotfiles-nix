(global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\^h 'backspace)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(require 'package)
(setq package-archives nil)
(setq package-enable-at-startup nil)
(package-initialize)

(require 'use-package)

(define-global-minor-mode global-settings-mode whitespace-mode
  (lambda ()
    (when (not (memq major-mode (list 'Buffer-menu-mode
                                      'vterm-mode)))
      (setq truncate-lines t
            truncate-partial-width-windows nil)
      (whitespace-mode))))
(global-settings-mode 1)

(add-hook 'after-init-hook
          (lambda ()
            (set-default-font "Source Code Pro-10")
            (load-theme 'gruvbox-dark-medium t)
            (setq whitespace-display-mappings
                  '((space-mark ?\  [?·] [?.]) ; space - middle dot
                    (space-mark ?\xA0  [?¤] [?_]) ; hard space - currency sign
                    (newline-mark ?\t [?→ ?\t]) ; tab
                    (newline-mark ?\n [?↲ ?\n]))) ;
            (set-background-color "#111")
            (set-face-background 'mode-line "#333")
            (set-face-background 'fringe "#111")
            (set-face-foreground 'whitespace-line nil)
            (set-face-background 'whitespace-line nil)
            (set-face-background 'whitespace-newline "#111")
            (set-face-background 'whitespace-tab "#111")
            (set-face-background 'whitespace-space-after-tab "#111")
            (set-face-background 'whitespace-space "#111")
            (set-face-background 'whitespace-indentation "#111")
            ;(setq truncate-lines t
            ;      truncate-partial-width-windows nil)
            (show-paren-mode 1)))

(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :config
  (progn
    ; C-s/C-r switches to the next/previous match.
    ; Enter executes the selected command.
    ; C-h f, while Smex is active, runs describe-function on the currently selected command.
    ; M-. jumps to the definition of the selected command.
    ; C-h w shows the key bindings for the selected command. (Via where-is.)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))

(use-package which-key
  :ensure t
  :init
  (setq which-key-show-early-on-C-h t
        which-key-idle-delay 0.5)
  :config
  (which-key-mode))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-center-content t
        dashboard-banner-logo-title nil
        dashboard-set-footer nil
        dashboard-startup-banner 'logo
        dashboard-items '((recents  . 30)))
                          ;(bookmarks . 5)
                          ;(projects . 5)
                          ;(agenda . 5)
                          ;(registers . 5)
  :config
  (dashboard-setup-startup-hook))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-w-in-emacs-state t
        evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (evil-set-leader '(normal motion) (kbd "<SPC>"))
  (evil-define-key '(normal motion) 'global
                   (kbd "<leader><SPC>") 'buffer-menu
                   (kbd "<leader>bb") 'buffer-menu
                   (kbd "<leader>bd") 'kill-buffer ; c-x k
                   (kbd "<leader>fs") 'save-buffer
                   (kbd "<leader>sf") 'find-file
                   (kbd "<leader>da") 'apropos-documentation
                   (kbd "<leader>dv") 'describe-variable
                   (kbd "<leader>df") 'describe-function
                   (kbd "<leader>dk") 'describe-key
                   (kbd "<leader>dm") 'describe-mode
                   (kbd "<leader>as") 'vterm
                   (kbd "<leader>ag") 'magit-status
                   (kbd "<leader>ar") 'ranger-select-files
                   (kbd "<leader>tl") 'toggle-truncate-lines
                   (kbd "<leader>tm") 'toggle-menu-bar)
  (dolist (mode (list emacs-lisp-mode-map
                      lisp-interaction-mode-map))
    (evil-define-key '(normal motion) mode
                     (kbd ",e") 'eval-buffer
                     (kbd ",l") 'eval-last-sexp))
  (evil-define-key '(normal motion) 'parinfer-mode
                   (kbd ",p") 'parinfer-toggle-mode))

(use-package vterm
  :init
  (setq vterm-kill-buffer-on-exit t)
  :config
  (evil-define-key 'insert vterm-mode-map
                   (kbd "C-\C-n") #'evil-normal-state
                   (kbd "C-e") #'vterm--self-insert
                   (kbd "C-f") #'vterm--self-insert
                   (kbd "C-a") #'vterm--self-insert
                   (kbd "C-v") #'vterm--self-insert
                   (kbd "C-b") #'vterm--self-insert
                   (kbd "C-w") #'vterm--self-insert
                   (kbd "C-u") #'vterm--self-insert
                   (kbd "C-d") #'vterm--self-insert
                   (kbd "C-n") #'vterm--self-insert
                   (kbd "C-m") #'vterm--self-insert
                   (kbd "C-p") #'vterm--self-insert
                   (kbd "C-j") #'vterm--self-insert
                   (kbd "C-k") #'vterm--self-insert
                   (kbd "C-r") #'vterm--self-insert
                   (kbd "C-t") #'vterm--self-insert
                   (kbd "C-g") #'vterm--self-insert
                   (kbd "C-c") #'vterm--self-insert
                   (kbd "C-SPC") #'vterm--self-insert
                   (kbd "C-d") #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map
                   (kbd "i") #'evil-insert-resume
                   (kbd "o") #'evil-insert-resume)
  (add-hook 'vterm-exit-functions
            (lambda (buffer str)
              (when (and buffer (not (local-variable-p 'dont-auto-kill buffer)))
                (message "kill vterm buffer %s" buffer)
                (kill-buffer buffer)))
            t))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package hy-mode
  :mode "\\.hy\\'")

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

(use-package ranger-select)

(defun toggle-menu-bar ()
  (interactive)
  (let ((mode (if menu-bar-mode -1 1)))
    (menu-bar-mode mode)))
