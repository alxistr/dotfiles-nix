(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(set-default-font "Source Code Pro-11")

(require 'package)
(setq package-archives nil)
(setq package-enable-at-startup nil)
(package-initialize)

(require 'use-package)

(load-theme 'gruvbox-dark-medium t)

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
        dashboard-items '((recents  . 30)
                          ;(bookmarks . 5)
                          ;(projects . 5)
                          ;(agenda . 5)
                          ;(registers . 5)
                          ))
  :config
  (dashboard-setup-startup-hook))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-w-in-emacs-state t
        evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "<SPC>"))
  (evil-define-key 'normal 'global (kbd "<leader><SPC>") 'buffer-menu)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'buffer-menu)
  (evil-define-key 'normal 'global (kbd "<leader>bx") 'kill-buffer) ; c-x k
  (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>sf") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>dv") 'describe-variable)
  (evil-define-key 'normal 'global (kbd "<leader>df") 'describe-function)
  (evil-define-key 'normal 'global (kbd "<leader>dk") 'describe-key)
  (evil-define-key 'normal 'global (kbd "<leader>dm") 'describe-mode)
  (evil-define-key 'normal 'global (kbd "<leader>da") 'apropos-documentation)
  (evil-define-key 'normal 'global (kbd "<leader>le") 'eval-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>ll") 'eval-last-sexp)
  (evil-define-key 'normal 'global (kbd "<leader>as") 'vterm)
  (evil-define-key 'normal 'global (kbd "<leader>ag") 'magit-status)
  (evil-define-key 'normal 'global (kbd "<leader>tp") 'parinfer-toggle-mode)
  (evil-define-key 'normal 'global (kbd "<leader>tm") 'toggle-menu-bar))

(use-package vterm)

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
  (progn
    (setq parinfer-extensions
          '(defaults
            evil
            ;lispy
            ;paredit
            ;smart-tab
            smart-yank)))
  :config
  (parinfer-toggle-mode)
  (add-hook 'clojure-mode-hook #'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  (add-hook 'common-lisp-mode-hook #'parinfer-mode)
  (add-hook 'scheme-mode-hook #'parinfer-mode)
  (add-hook 'hy-mode-hook #'parinfer-mode)
  (add-hook 'lisp-mode-hook #'parinfer-mode)
  (add-hook 'lisp-interaction-mode-hook #'parinfer-mode))

(defun toggle-menu-bar ()
  (interactive)
  (let ((mode (if menu-bar-mode -1 1)))
    (menu-bar-mode mode)))
