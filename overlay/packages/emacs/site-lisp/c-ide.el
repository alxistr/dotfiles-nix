(use-package company
  :init
  (setq company-require-match nil
        company-idle-delay 0.1)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key [(control ?\,)] 'company-complete-common)
  (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "C-j") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-k") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "M-j") 'company-select-next)
  (define-key company-active-map (kbd "M-k") 'company-select-previous)
  (when evil-want-C-u-scroll
    (define-key company-active-map (kbd "C-u") 'company-previous-page))
  (when evil-want-C-d-scroll
    (define-key company-active-map (kbd "C-d") 'company-next-page))
  (define-key company-search-map (kbd "C-j") 'company-select-next-or-abort)
  (define-key company-search-map (kbd "C-k") 'company-select-previous-or-abort)
  (define-key company-search-map (kbd "M-j") 'company-select-next)
  (define-key company-search-map (kbd "M-k") 'company-select-previous))

(provide 'c-ide)
