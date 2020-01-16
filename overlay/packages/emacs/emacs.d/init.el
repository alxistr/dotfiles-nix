(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(require 'package) 
(setq package-archives nil) 
(setq package-enable-at-startup nil)
(package-initialize)

(load-theme 'gruvbox-dark-medium t)

(require 'evil)
(evil-mode 1)
