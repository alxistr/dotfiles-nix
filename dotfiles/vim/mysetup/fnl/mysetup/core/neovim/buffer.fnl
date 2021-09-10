(ns :mysetup.core.neovim.buffer
    (:import :mysetup.core.fun
             {: seq->table
              : map-kv})
    (:import :mysetup.core.vim.runtime
             {: vim!})
    (:import vim.api
             {:nvim_buf_set_lines set-buf-lines
              :nvim_buf_get_lines get-buf-lines
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
              :nvim_set_current_buf set-current-buf}))

(defn get-buffer-text [buffer]
  (-> buffer
      (get-buf-lines 0 -1 false)
      (table.concat "\n")))

(defn set-buffer-text [buffer lines]
  (set-buf-lines buffer 0 -1 false lines))

(defn append-to-buffer [buffer lines]
  (set-buf-lines buffer -1 -1 false lines))

(defn create-buffer [name ...]
  (let [buffer (create-buf true false)]
    (when name
      (set-buf-name buffer name))
    (each [name value (-> [...]
                          (seq->table)
                          (pairs))]
      (set-buf-option buffer name value))
    buffer))

(defn collect-buffers [f]
  (->> (list-bufs)
       (map-kv (fn [[_ id]]
                 [(f id) id]))))

(defn get-buffers-names []
  (collect-buffers get-buf-name))

(defonce empty-start?
  (let [[first] (list-bufs)
        name (get-buf-name first)]
    (= "" name)))
