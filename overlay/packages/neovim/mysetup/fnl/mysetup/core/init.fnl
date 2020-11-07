(ns :mysetup.core)

(defonce done?
  (do
    (require :mysetup.core.fennel)
    true))
