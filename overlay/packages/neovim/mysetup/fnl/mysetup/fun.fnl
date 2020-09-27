(fn inc [v] (+ v 1))
(fn dec [v] (- v 1))

(fn nil? [v] (if (= nil v) true false))

(fn tappend [t value key]
  (let [t (if (nil? t) {} t)
        key (or key (inc (length t)))]
    (tset t key value)
    t))

(fn tdefault [t key default]
  (let [v (. t key)]
    (when (nil? v)
      (tset t key default)))
  t)

(fn range* [i pred]
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

(local range (range* 0 #(< $1 $2)))

(local irange (range* 1 #(<= $1 $2)))

(fn reduce* [f memo col key first?]
  (let [next-key (next col key)]
    (match [key first?]
     [nil true] (reduce* f memo col next-key false)
     [nil false] memo
     _ (let [memo* (f memo (. col key) key)]
         (reduce* f memo* col next-key false)))))

(fn reduce [f initial col]
  (reduce* f initial col nil true))

(fn filter [f col]
  (-> (fn [memo item key]
        (if (f item key)
          (tappend memo item key)
          memo))
      (reduce [] col)))

(fn map [f col]
  (-> (fn [memo value key]
        (tappend memo (f value key) key))
      (reduce [] col)))

(fn tuples [col]
  (-> (fn [memo value key]
        (tappend memo [key value]))
      (reduce {} col)))

(fn map-indexed [col]
  (-> (fn [memo item]
        (tappend memo item))
      (reduce {} col)))

(fn partition [n col]
  (-> (fn [memo value index]
        (let [k (inc (math.floor (/ (dec index) n)))]
          (tdefault memo k {})
          (tappend (. memo k) value)
          memo))
      (reduce {} (map-indexed col))))

(comment
  (do
    (s.pp (reduce #(+ $1 $2) 0 [1 2 3 4]))
    (s.pp (map #(* $1 $1) [1 2 3 4]))
    (s.pp (filter #(= 0 (% $ 2)) [1 2 3 4])))

  (do
    (s.pp (range 10))
    (s.pp (range 0 10 2))
    (s.pp (range 10 15))
    (s.pp (range 15 10))
    (s.pp (range 15 10)))

  (do
    (-> ["ok" "wtf" "wow"]
        (tuples)
        (s.pp))
    (-> {:a "ok" :b "wtf" :c "wow"}
        (tuples)
        (s.pp))
    (-> ["ok" "wtf" "wow"]
        (map-indexed)
        (s.pp))
    (-> {:a "ok" :b "wtf" :c "wow"}
        (map-indexed)
        (s.pp))
    (-> ["ok" "wtf" "wow"]
        (tuples)
        (map-indexed)
        (s.pp))
    (-> {:a "ok" :b "wtf" :c "wow"}
        (tuples)
        (map-indexed)
        (s.pp)))

  (do
    (s.pp (partition 3 (range 12))))

  nil)

{: inc : dec
 : nil?
 : tappend : tdefault
 : range : irange
 : filter : map : reduce
 : tuples : map-indexed : partition}
