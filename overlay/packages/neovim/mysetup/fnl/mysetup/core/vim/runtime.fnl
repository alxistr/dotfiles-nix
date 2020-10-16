(->> (require :mysetup.core.lua-proxy)
     (local {: create-proxy}))

(fn fmt! [f ...]
  (string.format f ...))

(fn join-if-table [value sep]
  (if (not= "table" (type value))
    value
    (table.concat value (or sep ","))))

(fn proxy-if-function [value opts]
  (if (not= "function" (type value))
    value
    (let [{: suffix : prefix} (or opts {})]
      (fmt! "%s %s()%s"
            (or prefix "lua")
            (create-proxy value)
            (or suffix "")))))

(fn vim! [...]
  (each [_ cmd (pairs [...])]
    (vim.api.nvim_command cmd)))

{: fmt!
 : vim!
 : join-if-table
 : proxy-if-function}
