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
      {: append-to-buffer} (require :mysetup.core.neovim.buffer)
      pop-option (fn [opts option default]
                   (let [value (. opts option)]
                     (when value
                       (tset opts option nil))
                     [opts (or value default)]))]
  (global ff #(fennelview $1 $2))
  (global pp* #(do
                 (-> (fennelview $1 $2)
                     (print))
                 nil))
  (global pp (fn [value opts]
               (let [opts (or opts {})
                     [opts buffer-name] (pop-option opts :buffer-name "*pretty-print*")
                     [_ buffer] (get-or-create buffer-name)]
                (when buffer
                  (->> (-> (fennelview value opts)
                           (vim.split "\n"))
                      (append-to-buffer buffer)))
                nil))))
