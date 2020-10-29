(ns :mysetup.core)

(defonce essential-loaded
  (do
    (require :mysetup.core.fennel)
    (require :mysetup.core.pretty-print)
    true))
