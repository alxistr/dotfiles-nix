(ns :mysetup.tools.scratch
    (:import :mysetup.core.vim
             {: fmt! : vim!})
    (:import :mysetup.core.neovim.buffer
             {: create-buffer
              : is-valid-buf?
              : is-loaded-buf?
              : empty-start?
              : set-current-buf}))

(defonce cache {:by-name {}})

(defn get-by-name [name]
  (let [buffer (-?> cache
                    (. :by-name)
                    (. name))]
    (when (and (not= buffer nil)
               (is-valid-buf? buffer))
      buffer)))

(defn new-cached [name ...]
  (let [buffer (create-buffer name ...)]
    (-> cache
        (. :by-name)
        (tset name buffer))
    buffer))

(defn get-or-create [name ...]
  (let [buffer (get-by-name name)]
    (if (and buffer (is-loaded-buf? buffer))
      [false buffer]
      [true (new-cached name
                        :buftype :nofile
                        :swapfile false
                        :buflisted true
                        ...)])))

(defn initial-scratch! [if-empty?]
  (let [if-empty? (if (= nil if-empty?)
                    true
                    if-empty?)]
    (when (or (not if-empty?)
              (and if-empty? empty-start?))
      (let [[_ buffer] (get-or-create "*scratch*" :filetype "fennel")]
        (set-current-buf buffer)))))
