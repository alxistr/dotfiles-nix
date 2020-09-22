(local get-range
  (fn [start end]
   (let [[_ y1 x1] (vim.call "getpos" start)
         [_ y2 x2] (vim.call "getpos" end)]
     (-> [[y1 x1] [y2 x2]]
         (vim.inspect)
         (print)))))

(local get-current-line #(get-range "'[" "']"))
(local get-selected-text #(get-range "'<" "'>"))

{: get-range
 : get-current-line
 : get-selected-text}
