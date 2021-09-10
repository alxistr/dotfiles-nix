(ns :mysetup.core.vim
    (:import :mysetup.core.vim.vimify
             {: proxy-if-function})
    (:import :mysetup.core.vim.runtime
             {: join-if-table : vim! : fmt!})
    (:import :mysetup.core.vim.au
             {: au : aug})
    (:import :mysetup.core.vim.attrs
             {: g! : o! : bo! : wo!})
    (:import :mysetup.core.vim.mappers
             {: map! : icmap! : nmap! : vmap! : smap!
              : xmap! : omap! : imap! : lmap! : cmap!
              : tmap!}))
