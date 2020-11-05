(ns :mysetup.core.vim.mappers
    (:import :mysetup.core.fun
             {: seq->table
              : map-kv
              : extends})
    (:import :mysetup.core.vim.vimify
             {: proxy-if-function})
    (:import :mysetup.core.vim.runtime
             {: vim!
              : fmt!})
    (:import vim.api
             {:nvim_set_keymap set-keymap
              :nvim_buf_set_keymap set-buf-keymap}))

(defn extend-bindings [bindings leader? local?]
  (let [prefix (if
                 leader? "<leader>"
                 local? "<localleader>"
                 "")]
    (map-kv (fn [[lhs rhs]]
              [(.. prefix lhs) rhs])
            bindings)))

(defn collect-opts [...]
  (->> (seq->table [...])
       (extends {:noremap? true
                 :leader? false
                 :local? false
                 :buffer? false
                 :silent? false
                 :expr? false})))

(defn bind [mode lhs rhs buffer? keymap-opts]
  (let [rhs (->> {:prefix ":lua" :suffix "<CR>"}
                 (proxy-if-function rhs))
        [buffer? buffer] (match buffer?
                           false [false nil]
                           true [true 0]
                           [true buffer?])]
    (if buffer?
      (set-buf-keymap buffer mode lhs rhs keymap-opts)
      (set-keymap mode lhs rhs keymap-opts))))

(defn create-mapper [mode]
  (fn [bindings ...]
    (let [{: leader? : local? : buffer?
           : noremap? : silent? : expr?} (collect-opts ...)]
      (each [lhs rhs (-> bindings
                         (extend-bindings leader? local?)
                         (pairs bindings))]
        (bind mode lhs rhs buffer? {:noremap noremap?
                                    :silent silent?
                                    :expr expr?})))))

(def map!   (create-mapper ""))
(def icmap! (create-mapper "!"))
(def nmap!  (create-mapper "n"))
(def vmap!  (create-mapper "v"))
(def smap!  (create-mapper "s"))
(def xmap!  (create-mapper "x"))
(def omap!  (create-mapper "o"))
(def imap!  (create-mapper "i"))
(def lmap!  (create-mapper "l"))
(def cmap!  (create-mapper "c"))
(def tmap!  (create-mapper "t"))
