(import :mysetup.core.vim
        {: fmt! : vim!})
(import :mysetup.core.neovim.buffer
        {: create-buffer
         : is-valid-buf?
         : is-loaded-buf?})

(fn get-cache []
  (require :mysetup.tools.scratch-cache))

(fn get-by-name [name]
  (let [buffer (-?> (get-cache)
                    (. :by-name)
                    (. name))]
    (when (and (not= buffer nil)
               (is-valid-buf? buffer))
      buffer)))

(fn new-cached [name ...]
  (let [buffer (create-buffer name ...)]
    (-> (get-cache)
        (. :by-name)
        (tset name buffer))
    buffer))

(fn get-or-create [name ...]
  (let [buffer (get-by-name name)]
    (if (and buffer (is-loaded-buf? buffer))
      [false buffer]
      [true (new-cached name
                        :buftype "nofile"
                        :swapfile false
                        :buflisted true
                        ...)])))

get-or-create
