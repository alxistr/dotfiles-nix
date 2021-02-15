(ns :mysetup.tools.term
    (:import :mysetup.core.vim.runtime
             {: vim!})
    (:import :mysetup.core.neovim.buffer
             {: create-buf
              : get-current-buf
              : set-current-buf})
    (:import vim.api
             {:nvim_command cmd!})
    (:import :mysetup.core.fun
             {: defaults})
    (:import :mysetup.tools.pretty-print
             {: pp : pp*}))

(defn run [cmd opts]
  (let [buffer (create-buf false true)
        previous (get-current-buf)
        on-exit (fn []
                  (set-current-buf previous))]
    (set-current-buf buffer)
    (->> {:on_exit on-exit
          :cwd (vim.fn.getcwd)}
         (defaults (or opts {}))
         (vim.fn.termopen cmd))
    (vim! "startinsert")))

; (defn fzf [items opts]
;   (let [a (->> opts
;               (defaults {:multiple false}))]))
;
; (run "ranger")
