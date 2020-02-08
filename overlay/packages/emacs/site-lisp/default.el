(require 'c-utils)
(require 'c-essential)
(require 'c-ui)
(require 'c-recent)
(require 'c-evil)
(require 'c-vterm)
(require 'c-ide)
(require 'c-lisps)
(require 'c-nix)

(require 'ranger)
(require 'fzf)

;(use-package fzf
;  :commands fzf/start
;  :init
;  (setq-default term-term-name "vt100"))

;(defun select-window-by-index (n)
;  (let ((window (nth n (window-list))))
;    (if (not window)
;      (message "no window %d" n)
;      (select-window window))))
