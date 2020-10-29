(ns :mysetup.tools.watch-buffers
    (:import (require :mysetup.core.fun)
             {: map})
    (:import (require :mysetup.core.vim)
             {: au : aug
              : fmt! : vim!
              : g! : o! : wo! : bo!
              : nmap! : icmap!})
    (:import :mysetup.core.vim.expand
             {: afile : abuf}))

(comment
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
              (unpack)))))
