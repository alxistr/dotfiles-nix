(->> (require :mysetup.core.lua-proxy)
     (local {: register-function}))

(fn fmt! [f ...]
  (string.format f ...))

(fn join-if-table [value sep]
  (if (not= "table" (type value))
    value
    (table.concat value (or sep ","))))

(fn register-if-function [value opts]
  (if (not= "function" (type value))
    value
    (let [{: suffix : prefix} (or opts {})]
      (fmt! "%s %s()%s"
            (or prefix "lua")
            (register-function value)
            (or suffix "")))))

(fn vim! [...]
  (each [_ cmd (pairs [...])]
    (vim.api.nvim_command cmd)))

{: fmt!
 : vim!
 : join-if-table
 : register-if-function}
