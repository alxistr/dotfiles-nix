(let [fennel (require :deps.fennel)]
  (table.insert (or package.loaders
                    package.searchers)
                fennel.searcher)
  (->> (-> package.path
           (string.gsub "/lua/" "/fnl/")
           (string.gsub ".lua;" ".fnl;")
           (string.gsub ".lua$" ".fnl"))
       (tset fennel :path)))

(let [fennelview (require :deps.fennelview)
      get-or-create (require :mysetup.tools.scratch)
      {: append-to-buffer} (require :mysetup.core.neovim.buffer)]
  (global ff #(fennelview $1 $2))
  (global pp* #(do
                 (-> (fennelview $1 $2)
                     (print))
                 nil))
  (global pp #(let [[_ buffer] (get-or-create "*pretty-print*")]
                (->> (-> (fennelview $1 $2)
                         (vim.split "\n"))
                     (append-to-buffer buffer))
                nil)))
