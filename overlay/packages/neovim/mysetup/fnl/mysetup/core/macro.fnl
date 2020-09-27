{:augroup (fn [name ...]
            `(do
               (vim! (fmt! "augroup %s" ,name))
               (vim! (fmt! "au!"))
               (do ,...)
               (vim! (fmt! "augroup END"))))}
