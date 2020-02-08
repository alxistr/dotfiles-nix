(require 'whitespace)

(defvar is-init-done nil)

(define-global-minor-mode enhancements-minor-mode whitespace-mode
  (lambda ()
    (setup-buffer-enhancements)))

(add-hook 'after-init-hook
          (lambda ()
            (setq is-init-done t)
            (show-paren-mode 1)))

(add-hook 'window-setup-hook
          (lambda ()
            (set-default-font "Source Code Pro-10")
            (switch-light-theme)
            ;(switch-dark-theme)
            (let ((window (split-window-horizontally)))
              (set-window-buffer window (messages-buffer)))))

(defun switch-dark-theme () 
  (interactive)
  (load-theme 'gruvbox-dark-soft t)
  ;(set-face-background 'mode-line "#333")
  ;(set-face-background 'mode-line-inactive "#111")
  ;(set-face-background 'fringe "#050505")
  (set-face-foreground 'whitespace-line nil)
  (set-face-background 'whitespace-line nil)
  (set-face-background 'whitespace-newline nil)
  (set-face-background 'whitespace-tab nil)
  (set-face-background 'whitespace-space-after-tab nil)
  ;(set-face-foreground 'whitespace-space nil)
  ;(set-face-background 'whitespace-space nil)
  (set-face-background 'whitespace-indentation nil)
  nil)

(defun switch-light-theme () 
  (interactive)
  (load-theme 'gruvbox-light-medium t)
  (set-face-background 'mode-line "#ebdbb2")
  (set-face-background 'mode-line-inactive "#f2e5bc")
  ;(set-face-background 'fringe nil)
  (set-face-foreground 'whitespace-line nil)
  (set-face-background 'whitespace-line nil)
  (set-face-background 'whitespace-newline nil)
  (set-face-background 'whitespace-tab nil)
  (set-face-background 'whitespace-space-after-tab nil)
  ;(set-face-foreground 'whitespace-space nil)
  ;(set-face-background 'whitespace-space nil)
  (set-face-background 'whitespace-indentation nil)
  nil)

(defun setup-buffer-enhancements ()
  (when (memq major-mode (list 'vterm-mode))
    (evil-insert-state))
  (message "enter to \"%s\" (%s)" (buffer-name) major-mode)
  (let ((is-initial-fundamental (and (equal major-mode 'fundamental-mode) 
                                     (not is-init-done)))
        (is-ignored-major (memq major-mode (list 'help-mode
                                                 'woman-mode
                                                 'completion-list-mode
                                                 'Buffer-menu-mode
                                                 'vterm-mode
                                                 ; 'messages-buffer-mode
                                                 'minibuffer-inactive-mode))))
    (when (and (not is-initial-fundamental) (not is-ignored-major))
      (setq truncate-lines t
            truncate-partial-width-windows nil)
      (whitespace-mode))))

(defun toggle-menu-bar ()
  (interactive)
  (let ((mode (if menu-bar-mode -1 1)))
    (menu-bar-mode mode)))

(use-package which-key
  :ensure t
  :init
  (setq which-key-show-early-on-C-h t
        which-key-idle-delay 0.5)
  :config
  (which-key-mode))

;(use-package smex
;  :ensure t
;  :init
;  (smex-initialize)
;  :config
;  (progn
;    ; C-s/C-r switches to the next/previous match.
;    ; Enter executes the selected command.
;    ; C-h f, while Smex is active, runs describe-function on the currently selected command.
;    ; M-. jumps to the definition of the selected command.
;    ; C-h w shows the key bindings for the selected command. (Via where-is.)
;    (global-set-key (kbd "M-x") 'smex)
;    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))

;(use-package dashboard
;  :ensure t
;  :init
;  (setq dashboard-center-content t
;        dashboard-banner-logo-title nil
;        dashboard-set-footer nil
;        dashboard-startup-banner 'logo
;        dashboard-items '((recents  . 30)))
;                          ;(bookmarks . 5)
;                          ;(projects . 5)
;                          ;(agenda . 5)
;                          ;(registers . 5)
;  :config
;  (dashboard-setup-startup-hook))

;(use-package powerline
;  :ensure t
;  :config
;  (powerline-center-evil-theme))


;; todo modeline

;(ido-mode t) ;;;;; TODO

(enhancements-minor-mode 1)

(provide 'c-ui)
