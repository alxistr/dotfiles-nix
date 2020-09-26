(local fennel (require :deps.fennel))

(require :mysetup.au)

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

(global s
  {: fennel

   :pp #(print (vim.inspect $))

   :fnleval #(fennel.eval $)
   :fnlfile #(-> (vim.fn.expand (or $ "%"))
                 (fennel.dofile))

   :text (require :mysetup.text)})
