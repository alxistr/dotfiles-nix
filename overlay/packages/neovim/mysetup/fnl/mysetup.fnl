(local fennel (require :deps.fennel))

(table.insert
    (or package.loaders package.searchers)
    fennel.searcher)

(tset fennel :path
      (-> package.path
          (string.gsub "/lua/" "/fnl/")
          (string.gsub ".lua;" ".fnl;")
          (string.gsub ".lua$" ".fnl")))

(let [nvim-lsp (require :nvim_lsp)]
  (nvim-lsp.sumneko_lua.setup {})
  (nvim-lsp.clojure_lsp.setup {})
  (nvim-lsp.pyls.setup {}))
