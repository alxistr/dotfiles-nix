(ns :mysetup.core.text)

(defn get-range [start end]
  (let [[_ y1 x1] (vim.call "getpos" start)
        [_ y2 x2] (vim.call "getpos" end)]
    (-> [[y1 x1] [y2 x2]]
        (vim.inspect)
        (print))))

(def get-current-line #(get-range "'[" "']"))
(def get-selected-text #(get-range "'<" "'>"))
