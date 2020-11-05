(ns :mysetup.tools.fennel-repl
    (:import :fennelns.fennel
             fennel)
    (:import :mysetup.core.pretty-print
             {: pp : pp*})
    (:import :mysetup.core.neovim.buffer
             {: get-current-buf
              : get-buf-option
              : get-buf-name
              : get-buffer-text}))

(defn -eval-buffer [pretty-printer]
  (fn []
    (let [buf (get-current-buf)
          nofile? (= :nofile (get-buf-option buf :buftype))]
      (if nofile?
        (->> (get-buffer-text buf)
             (fennel.eval)
             (pretty-printer))
        (->> (get-buf-name buf)
             (fennel.dofile)
             (pretty-printer))))))

(def eval-buffer (-eval-buffer pp))
(def eval-buffer* (-eval-buffer pp*))
