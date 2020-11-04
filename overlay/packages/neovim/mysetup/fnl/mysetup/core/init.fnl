(ns :mysetup.core)

(defonce done?
  (do
    (require :mysetup.core.fennel)
    (require :mysetup.core.pretty-print)
    true))
