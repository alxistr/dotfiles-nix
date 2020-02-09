(require 'vterm)
(require 'evil)

(defun rs--make-choose-command (filename)
  (string-join (list "ranger --choosefiles="
                     filename
                     " && "
                     "exit\n")
               ""))

(defun ranger-select-files ()
  (interactive)
  (let ((tmp-filename (make-temp-file "select-"))
        (tmp-buffer (make-temp-name "select-")))
    (switch-to-buffer tmp-buffer)
    (vterm-mode)
    (vterm-send-string (rs--make-choose-command tmp-filename))
    (setq-local dont-auto-kill t)
    (setq-local rs--filename tmp-filename)
    (evil-insert-state)))

(add-hook 'vterm-exit-functions
          (lambda (buffer str)
            (when (and buffer (local-variable-p 'rs--filename buffer))
              (let ((tmp-filename (buffer-local-value 'rs--filename buffer)))
                (kill-buffer buffer)
                (dolist (filename (utils--read-lines tmp-filename))
                  (find-file filename))
                (delete-file tmp-filename))))
          t)

(provide 'ranger)
