(global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\^h 'backspace)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(setq-default indent-tabs-mode nil)

(setq initial-scratch-message 
      (concat (format ";; %s@%s // %s\n" (getenv "USER") (system-name) system-configuration)
              "\n"))
(setq inhibit-startup-screen t)
(setq initial-buffer-choice t)

(setq whitespace-display-mappings
      '((space-mark ?\  [?·] [?.]) ; space - middle dot
        (space-mark ?\xA0  [?¤] [?_]) ; hard space - currency sign
        (newline-mark ?\t [?→ ?\t]) ; tab
        (newline-mark ?\n [?↲ ?\n]))) ;

(require 'package)
(setq package-archives nil)
(setq package-enable-at-startup nil)
(package-initialize)

(require 'use-package)

(provide 'c-essential)
