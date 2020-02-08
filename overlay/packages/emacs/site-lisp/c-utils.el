(defun utils--read-lines (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (split-string (buffer-string) "\n" t)))

(defun utils--get-project ()
  (or (locate-dominating-file default-directory ".git")
      default-directory))

(provide 'c-utils)
