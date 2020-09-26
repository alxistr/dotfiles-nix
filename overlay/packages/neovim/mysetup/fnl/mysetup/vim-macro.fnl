{:fmt! (fn [f ...]
         `(string.format ,f ,...))

 :vim! (fn [cmd]
         `(vim.api.nvim_command ,cmd))

 :augroup (fn [name ...]
            `(do
               (vim! (fmt! "augroup %s" ,name))
               (vim! (fmt! "au!"))
               (do ,...)
               (vim! (fmt! "augroup END"))))

 :au (fn [opts]
       `(let [opts# ,opts
              event# (or (. opts# :event)
                         "*")
              pattern# (or (. opts# :pattern)
                           "*")
              cmd# (. opts# :cmd)]
          (fmt! "au %s %s %s" event# pattern# cmd#)))

 :g! (fn [vars]
       `(each [name# value# (pairs ,vars)]
          (vim.api.nvim_set_var name# value#)))}
