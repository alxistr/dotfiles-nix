(->> (require :mysetup.core.fun)
     (local {: seq->table
             : map-kv}))
(local {:nvim_buf_set_lines set-buf-lines
        :nvim_create_buf create-buf
        :nvim_list_bufs list-bufs
        :nvim_buf_is_valid is-valid-buf?
        :nvim_buf_is_loaded is-loaded-buf?
        :nvim_buf_set_name set-buf-name
        :nvim_buf_get_name get-buf-name
        :nvim_buf_set_option set-buf-option
        :nvim_buf_get_option get-buf-option
        :nvim_buf_set_var set-buf-var
        :nvim_buf_get_var get-buf-var
        :nvim_get_current_buf get-current-buf
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

(fn get-buffers-names []
  (collect-buffers get-buf-name))

{: set-buffer-text
 : append-to-buffer
 : create-buffer
 : collect-buffers
 : get-buffers-names

 : is-valid-buf?
 : is-loaded-buf?

 : set-current-buf : get-current-buf

 : set-buf-name : get-buf-name
 : set-buf-option : get-buf-option
 : set-buf-var : get-buf-var}
