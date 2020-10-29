(ns :mysetup.core.vim
    (:import :mysetup.core.vim.runtime
             {: join-if-table
              : proxy-if-function
              : vim! : fmt!})
    (:import :mysetup.core.vim.au
             {: au : aug})
    (:import :mysetup.core.vim.attrs
             {: g! : o! : bo! : wo!})
    (:import :mysetup.core.vim.mappers
             {: map! : icmap! : nmap! : vmap! : smap!
              : xmap! : omap! : imap! : lmap! : cmap!
              : tmap!}))
