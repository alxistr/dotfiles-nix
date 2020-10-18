(->> (require :mysetup.core.fun)
     (local {: map}))
(->> (require :mysetup.core.vim)
     (local {: au : aug
             : fmt! : vim!
             : g! : o! : wo! : bo!
             : nmap! : icmap!}))
(->> (require :mysetup.core.vim.expand)
     (local {: afile : abuf}))

(let [name "*events*"
      callback (fn [eventname]
                 #(let [afile* (afile)]
                    (when (not= afile* name)
                      (pp {:event eventname
                           :afile afile*
                           :abuf (abuf)}
                          {:buffer-name name}))))]
  (aug "mysetup-watch-buffers"
       (->> ["BufNew"
             "BufDelete"]
            (map (fn [name]
                   {:event name
                    :cmd (callback name)}))
            (unpack))))
