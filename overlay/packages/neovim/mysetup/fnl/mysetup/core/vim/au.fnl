(->> (require :mysetup.core.vim.runtime)
     (local {: join-if-table
             : proxy-if-function
             : vim!
             : fmt!}))

(fn au [opts]
  (let [event (-> (or (. opts :event)
                      "*")
                  (join-if-table))
        pattern (-> (or (. opts :pattern)
                       "*")
                    (join-if-table))
        cmd (-> (. opts :cmd)
                (proxy-if-function))]
    (fmt! "au %s %s %s" event pattern cmd)))

(fn augroup [name ...]
  (vim! (fmt! "augroup %s" name))
  (vim! (fmt! "au!"))
  (each [_ opts (pairs [...])]
    (vim! (au opts)))
  (vim! (fmt! "augroup END")))

{: au : augroup :aug augroup}
