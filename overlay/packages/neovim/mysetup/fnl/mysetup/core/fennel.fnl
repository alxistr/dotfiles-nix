(global fennel (require :deps.fennel))

(do
  ; install fnl loader
  (table.insert (or package.loaders
                    package.searchers)
                fennel.searcher)
  (->> (-> package.path
           (string.gsub "/lua/" "/fnl/")
           (string.gsub ".lua;" ".fnl;")
           (string.gsub ".lua$" ".fnl"))
       (tset fennel :path)))

(global fnleval #(fennel.eval $))

(global fnlfile #(-> (vim.fn.expand (or $ "%"))
                     (fennel.dofile)))

(global pp #(print (vim.inspect $)))
