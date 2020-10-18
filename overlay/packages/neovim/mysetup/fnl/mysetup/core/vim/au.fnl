(ns :mysetup.core.vim.au
    (:import :mysetup.core.vim.runtime
             {: join-if-table
              : proxy-if-function
              : vim!
              : fmt!}))

(defn au [opts]
  (let [event (-> (or (. opts :event)
                      "*")
                  (join-if-table))
        pattern (-> (or (. opts :pattern)
                       "*")
                    (join-if-table))
        cmd (-> (. opts :cmd)
                (proxy-if-function))]
    (fmt! "au %s %s %s" event pattern cmd)))

(defn aug [name ...]
  (vim! (fmt! "augroup %s" name))
  (vim! (fmt! "au!"))
  (each [_ opts (pairs [...])]
    (vim! (au opts)))
  (vim! (fmt! "augroup END")))
