(ns :mysetup.core.vim.runtime)

(defn fmt! [f ...]
  (string.format f ...))

(defn join-if-table [value sep]
  (if (not= "table" (type value))
    value
    (table.concat value (or sep ","))))

(defn vim! [...]
  (each [_ cmd (pairs [...])]
    (vim.api.nvim_command cmd)))
