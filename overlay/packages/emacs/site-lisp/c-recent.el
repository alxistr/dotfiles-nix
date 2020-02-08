(use-package recentf
  :ensure t
  :init
  (setq recentf-max-menu-items nil
        recentf-max-saved-items nil)
  :config
  (recentf-mode 1))

(provide 'c-recent)
