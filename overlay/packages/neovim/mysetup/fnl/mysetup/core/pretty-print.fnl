(ns :mysetup.core.pretty-print
    (:import :deps.fennelview
             fennelview)
    (:import :mysetup.tools.scratch
             get-or-create)
    (:import :mysetup.core.neovim.buffer
             {: append-to-buffer
              : set-current-buf}))

(fn pop-option [opts option default]
  (let [value (. opts option)]
    (when value
      (tset opts option nil))
    [opts (or value default)]))

(global ff #(fennelview $1 $2))

(global pp* #(do
               (-> (fennelview $1 $2)
                   (print))
               nil))

(global pp
  (fn [value opts]
    (let [opts (or opts {})
          [opts name] (pop-option opts :buffer-name "*pretty-print*")
          [opts switch-to] (pop-option opts :switch-to)
          [_ buffer] (get-or-create name)]
      (when buffer
        (->> (-> (fennelview value opts)
                 (vim.split "\n"))
             (append-to-buffer buffer))
        (when switch-to
          (set-current-buf buffer)))
      nil)))
