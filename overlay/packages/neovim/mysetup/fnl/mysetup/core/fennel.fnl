(global fennel (require :deps.fennel))
(global fennelview (require :deps.fennelview))

(do
  (table.insert (or package.loaders
                    package.searchers)
                fennel.searcher)
  (->> (-> package.path
           (string.gsub "/lua/" "/fnl/")
           (string.gsub ".lua;" ".fnl;")
           (string.gsub ".lua$" ".fnl"))
       (tset fennel :path)))

(global pp #(print (fennelview $1 $2)))
