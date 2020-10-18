(ns :mysetup.core.vim.runtime
    (:import :mysetup.core.lua-proxy
             {: create-proxy}))

(defn fmt! [f ...]
  (string.format f ...))

(defn join-if-table [value sep]
  (if (not= "table" (type value))
    value
    (table.concat value (or sep ","))))

(defn proxy-if-function [value opts]
  (if (not= "function" (type value))
    value
    (let [{: suffix : prefix} (or opts {})]
      (fmt! "%s %s()%s"
            (or prefix "lua")
            (create-proxy value)
            (or suffix "")))))

(defn vim! [...]
  (each [_ cmd (pairs [...])]
    (vim.api.nvim_command cmd)))
