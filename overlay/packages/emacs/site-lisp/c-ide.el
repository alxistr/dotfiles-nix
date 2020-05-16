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

(use-package lsp-mode
 :after evil
 :hook ((clojure-mode . lsp)
        (clojurec-mode . lsp)
        (clojurescript-mode . lsp))
 :config
 (dolist (m '(clojure-mode
              clojurec-mode
              clojurescript-mode
              clojurex-mode))
   (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
 (setq lsp-enable-indentation nil
       lsp-enable-snippet nil
       lsp-clojure-server-command '("bash" "-c" "clojure-lsp"))
 (evil-define-key '(normal motion) 'lsp-mode
   (kbd "<leader>lsr") 'lsp-workspace-restart
   (kbd "<leader>lrr") 'lsp-rename
   (kbd "<leader>lri") 'lsp-organize-imports
   (kbd "<leader>lfr") 'lsp-find-references
   (kbd "<leader>lfi") 'lsp-find-implementation
   (kbd "<leader>lfd") 'lsp-find-definition
   (kbd "<leader>lfa") 'xref-find-apropos))

(use-package company-lsp
  :after (:all lsp-mode company)
  :config
  (push 'company-lsp company-backends))

(provide 'c-ide)
