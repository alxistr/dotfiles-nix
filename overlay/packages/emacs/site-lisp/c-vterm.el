(use-package vterm
  :config
  (setq vterm-keymap-exceptions nil)
  (evil-define-key 'emacs vterm-mode-map
                   (kbd "C-h") #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map
                   (kbd "C-\C-n") #'evil-normal-state
                   (kbd "C-h") #'vterm--self-insert
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
                   (kbd "C-SPC") #'vterm--self-insert)
  ;(evil-define-key '(normal motion) 'global
  ;                 (kbd "C-d") #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map
                   (kbd "i") #'evil-insert-resume
                   (kbd "o") #'evil-insert-resume)
  (add-hook 'vterm-exit-functions
            (lambda (buffer str)
              (when (and buffer (not (local-variable-p 'dont-auto-kill buffer)))
                (message "kill vterm buffer %s" buffer)
                (kill-buffer buffer)))
            t))

(provide 'c-vterm)
