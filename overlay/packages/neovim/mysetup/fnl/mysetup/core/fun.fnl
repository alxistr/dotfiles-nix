(ns :mysetup.core.fun)

(defn inc [v] (+ v 1))

(defn dec [v] (- v 1))

(defn nil? [v] (if (= nil v) true false))

(defn tappend [t value key]
  (let [t (if (nil? t) {} t)
        key (or key (inc (length t)))]
    (tset t key value)
    t))

(defn tpop [t key default]
  (let [value (or (. t key)
                  default)]
    (tset t key nil)
    value))

(defn tdefault [t key default]
  (let [v (. t key)]
    (when (nil? v)
      (tset t key default)))
  t)

(defn- range* [i pred]
  (fn r [a b d]
    (match [a b d]
      [a nil nil] (r i a 1)
      [a b nil] (r a b 1)
      ([a b d] ? (< b a)) (r b a d)
      _ (let [s {:i a :m []}]
          (while (pred s.i b)
            (tappend s.m s.i)
            (set s.i (+ s.i d)))
          s.m))))

(def range (range* 0 #(< $1 $2)))
(def irange (range* 1 #(<= $1 $2)))

(defn- reduce* [f memo col key first?]
  (let [next-key (next col key)]
    (match [key first?]
     [nil true] (reduce* f memo col next-key false)
     [nil false] memo
     _ (let [memo* (f memo (. col key) key)]
         (reduce* f memo* col next-key false)))))

(defn reduce [f initial col]
  (reduce* f initial col nil true))

(defn filter [f col]
  (-> (fn [memo item key]
        (if (f item key)
          (tappend memo item key)
          memo))
      (reduce [] col)))

(defn map [f col]
  (-> (fn [memo value key]
        (tappend memo (f value key) key))
      (reduce [] col)))

(defn tuples [col]
  (-> (fn [memo value key]
        (tappend memo [key value]))
      (reduce {} col)))

(defn tuples->table [col]
  (reduce (fn [memo [key value]]
            (tappend memo value key))
          {}
          col))

(defn map-indexed [col]
  (-> (fn [memo item]
        (tappend memo item))
      (reduce {} col)))

(defn partition [n col]
  (-> (fn [memo value index]
        (let [k (inc (math.floor (/ (dec index) n)))]
          (tdefault memo k {})
          (tappend (. memo k) value)
          memo))
      (reduce {} (map-indexed col))))

(defn extends [t p]
  (reduce (fn [memo [k v]]
            (tset memo k v)
            memo)
          t
          (tuples p)))

(defn defaults [t p]
  (reduce (fn [memo [k v]]
            (tdefault memo k v))
          t
          (tuples p)))

(defn keys [col]
  (-> (fn [memo value key]
        (tappend memo key))
      (reduce [] col)))

(defn map-kv [f col]
  (->> col
       (tuples)
       (map f)
       (tuples->table)))

(defn seq->table [s]
   (->> (partition 2 s)
        (tuples->table)))
