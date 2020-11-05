(ns :mysetup.core.pretty-print
    (:import :fennelview
             fennelview)
    (:import :mysetup.tools.scratch
             {: get-or-create})
    (:import :mysetup.core.neovim.buffer
             {: append-to-buffer
              : set-current-buf}))

(def- default-pp-buffer-name "*pretty-print*")

(defn- pop-option [opts option default]
  (let [value (. opts option)]
    (when value
      (tset opts option nil))
    [opts (or value default)]))

(def ff #(fennelview $1 $2))

(defn pp* [value opts]
  (-> (fennelview value opts)
      (print))
  value)

(defn pp [value opts]
  (let [opts (or opts {})
        [opts name] (pop-option opts :buffer-name default-pp-buffer-name)
        [opts switch-to] (pop-option opts :switch-to)
        [_ buffer] (get-or-create name)]
    (when buffer
      (->> (-> (fennelview value opts)
               (vim.split "\n"))
           (append-to-buffer buffer))
      (if switch-to
        (set-current-buf buffer)
        (print (.. "printed to " name))))
    value))
