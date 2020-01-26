(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(set-default-font "Source Code Pro-11")

; package
(require 'package)
(setq package-archives nil)
(setq package-enable-at-startup nil)
(package-initialize)

; theming
(load-theme 'gruvbox-dark-medium t)

; whichkey
(setq which-key-show-early-on-C-h t
      which-key-idle-delay 0.3)
(require 'which-key)
(which-key-mode)

; modal
(setq evil-want-C-w-in-emacs-state t
      evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

(evil-set-leader 'normal (kbd "<SPC>"))
(evil-define-key 'normal 'global (kbd "<leader><SPC>") 'buffer-menu)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'buffer-menu)
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)

; libvterm
(require 'vterm)
