(->> (require :mysetup.core.fun)
     (local {: seq->table
             : map-kv}))
(local {:nvim_buf_set_lines set-buf-lines
        :nvim_create_buf create-buf
        :nvim_buf_set_name set-buf-name
        :nvim_buf_get_name get-buf-name
        :nvim_buf_set_option set-buf-option
        :nvim_list_bufs list-bufs
        :nvim_set_current_buf set-current-buf}
       vim.api)

(fn set-buffer-text [buffer lines]
  (set-buf-lines buffer 0 -1 false lines))

(fn append-to-buffer [buffer lines]
  (set-buf-lines buffer -1 -1 false lines))

(fn create-buffer [name ...]
  (let [buffer (create-buf true false)]
    (when name
      (set-buf-name buffer name))
    (each [name value (-> [...]
                          (seq->table)
                          (pairs))]
      (set-buf-option buffer name value))
    buffer))

(fn collect-buffers [f]
  (->> (list-bufs)
       (map-kv (fn [[_ id]]
                 [(f id) id]))))

(fn get-buffers []
  (collect-buffers get-buf-name))

(let [buf (create-buffer "*temp*" :buftype "nofile")]
  (set-current-buf buf)
  (->> ["line1"
        "line2"
        "line3"]
       (append-to-buffer buf)))
