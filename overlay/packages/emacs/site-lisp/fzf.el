(defun fzf--sentinel (process event)
  (let ((buffer (process-buffer process)))
    (when (and buffer (local-variable-p 'fzf--filename buffer))
      (let ((path (buffer-local-value 'fzf--path buffer))
            (tmp-filename (buffer-local-value 'fzf--filename buffer)))
        (kill-buffer buffer)
        (dolist (filename (utils--read-lines tmp-filename))
          (find-file (concat (file-name-as-directory path) filename)))
        (delete-file tmp-filename)))))

(defun fzf-search-git-files ()
  (interactive)
  (let ((process-environment (append ;"FZF_DEFAULT_COMMAND=git ls-files"
                                     '("FZF_DEFAULT_COMMAND=git ls-files")
                                     ;'("FZF_DEFAULT_COMMAND=ag --nobreak --nonumbers --noheading .")
                                    ;'()
                                     process-environment))
        (default-directory (utils--get-project))
        (tmp-filename (make-temp-file "fzf-"))
        (tmp-buffer (make-temp-name "fzf-"))
        (previous-vterm-shell vterm-shell))
    (switch-to-buffer tmp-buffer)
    (setq vterm-shell (format "fzf -m >%s" tmp-filename))
    (vterm-mode)
    (set-process-sentinel (get-buffer-process tmp-buffer) 'fzf--sentinel)
    (setq-local fzf--filename tmp-filename)
    (setq-local fzf--path default-directory)
    (setq vterm-shell previous-vterm-shell)))

(provide 'fzf)

;(add-hook 'vterm-exit-functions
;          (lambda (buffer str)
;            (when (and buffer (local-variable-p 'fzfs--v-1))
;              ;(message "locals %s" (buffer-local-variables))
;              (while (accept-process-output))
;              (dolist (item (buffer-local-variables))
;                (message "local %s" item))
;              (message "process %s" (get-buffer-process buffer))
;              (with-current-buffer buffer
;                (message "content: %s" (buffer-string)))
;              ;(with-current-buffer buffer
;              ;  (message "content2: %s" (buffer-substring-no-properties (point-min) (point-max))))
;              (message "str: %s" str)))
;          t)

;(defun fzf--read-lines (filename)
;  (with-temp-buffer
;    (insert-file-contents filename)
;    (split-string (buffer-string) "\n" t)))

;(defun fzf--get-path ()
;  (or (locate-dominating-file default-directory ".git")
;      default-directory))
