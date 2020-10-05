(->> (require :mysetup.core.lua-proxy)
     (local {: register-function}))

(fn fmt! [f ...]
  (string.format f ...))

(fn join-if-table [value sep]
  (if (not= "table" (type value))
    value
    (table.concat value (or sep ","))))

(fn register-if-function [value]
  (if (not= "function" (type value))
    value
    (->> (register-function value)
         (fmt! "lua %s()"))))

(fn vim! [cmd]
  (vim.api.nvim_command cmd))

{: fmt!
 : vim!
 : join-if-table
 : register-if-function}
