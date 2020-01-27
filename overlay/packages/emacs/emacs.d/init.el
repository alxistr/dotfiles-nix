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

; theming
(load-theme 'gruvbox-dark-medium t)

; whichkey
(use-package which-key
  :ensure t
  ; :bind
  ; (("C-," . parinfer-toggle-mode))
  :init
  (setq which-key-show-early-on-C-h t
        which-key-idle-delay 0.3)
  :config
  (which-key-mode))

; modal
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-w-in-emacs-state t
        evil-want-C-u-scroll t)
  :config
  (progn
    (evil-mode 1)
    (evil-set-leader 'normal (kbd "<SPC>"))
    (evil-define-key 'normal 'global (kbd "<leader><SPC>") 'buffer-menu)
    (evil-define-key 'normal 'global (kbd "<leader>bb") 'buffer-menu)
    (evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>sf") 'find-file)
    (evil-define-key 'normal 'global (kbd "<leader>dv") 'describe-variable)
    (evil-define-key 'normal 'global (kbd "<leader>df") 'describe-function)
    (evil-define-key 'normal 'global (kbd "<leader>dk") 'describe-key)
    (evil-define-key 'normal 'global (kbd "<leader>dm") 'describe-mode)
    (evil-define-key 'normal 'global (kbd "<leader>lp") 'parinfer-toggle-mode)
    (evil-define-key 'normal 'global (kbd "<leader>as") 'vterm)))

; libvterm
(require 'vterm)

; parinfer
(use-package parinfer
  :ensure t
  :init
  (progn
    (setq parinfer-extensions
          '(defaults
            pretty-parens
            evil
            lispy
            paredit
            smart-tab
            smart-yank)))
  :config
  (progn
    ; (parinfer-toggle-mode)
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)
    (add-hook 'lisp-interaction-mode-hook #'parinfer-mode)))
