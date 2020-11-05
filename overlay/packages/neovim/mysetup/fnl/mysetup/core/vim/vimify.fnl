(ns :mysetup.core.vim.vimify
    (:import :mysetup.core.vim.runtime
             {: fmt!}))

(defonce cache {:counter 0
                :funcs {}})

(defn get-id []
  (let [id cache.counter]
    (tset cache :counter (+ id 1))
    id))

(defn get-mapped [f]
  (let [id (get-id)]
    (tset cache.funcs id f)
    id))

(defn create-proxy [f]
  (let [id (get-mapped f)]
    (.. "require(\""
        :mysetup.core.vim.vimify
        "\").cache.funcs["
        id
        "]")))

(defn create-accessor [value]
  (let [[path name] value]
    (.. "require(\""
        path
        "\")[\""
        name
        "\"]")))

(defn fmt-viml [value opts]
  (let [{: suffix : prefix} (or opts {})]
    (fmt! "%s %s()%s"
          (or prefix "lua")
          value
          (or suffix ""))))

(defn proxy-if-function [value opts]
  (match (type value)
    "function" (-> (create-proxy value)
                   (fmt-viml  opts))
    "table" (-> (create-accessor value)
                (fmt-viml  opts))
    _ value))
